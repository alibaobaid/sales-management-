module ImportFile
  extend ActiveSupport::Concern

  def import(file)
    result = { failed: [] }
    spreadsheet = open_spreadsheet(file)
    sheet = spreadsheet.sheet(0)
    required_header = ['م', 'التاريخ', 'المنطقة', 'اسم المندوب', 'اسم المسوق', 'نوع العملية', 'صنف', 'الكمية', 'القيمة', 'عمولة المندوب',
      'تحويلات من المندوب', 'المطلوب من المندوب', 'عمولة المسوق', 'تحويلات للمسوق', 'حساب المسوق', 'مصروفات يومية', 'تحويلات للمدير',
      'عمولة المدير', 'جوال الزبون']
    header = sheet.row(2).map { |h| h.try(:strip) }

    missing_header = required_header - header
    if missing_header.present?
      result[:failed] << {
        name: 'اعمدة مفقوده',
        error: missing_header.join(', ')
      }
      return result
    end

    header_data = Hash.new do |hash, key|
      hash[key] = columns_data(sheet, header, key)
    end

    names_delegate = Delegate.pluck(:id, :name).to_h
    names_marketer = Marketer.pluck(:id, :name).to_h
    names_assistant = Assistant.pluck(:id, :name).to_h
    operation_numbers = SalesOperation.pluck(:operation_number)
    manager_id = Manger.first&.id || Manger.create(name: 'افتراضي', city: 'افتراضي').id

    (3..sheet.last_row).each do |i|
      j = i-3
      next unless header_data['نوع العملية'][j] == 'بيع'

      delegate_id = \
        if names_delegate.values.include?(header_data['اسم المندوب'][j])
          names_delegate.key(header_data['اسم المندوب'][j])
        end
      marketer_id = \
        if names_marketer.values.include?(header_data['اسم المسوق'][j])
          names_marketer.key(header_data['اسم المسوق'][j])
        end

      SalesOperation.transaction do
        if delegate_id.nil?
          delegate = Delegate.create(name: header_data['اسم المندوب'][j], city: header_data['المنطقة'][j])
          if delegate.invalid?
            result[:failed] << {
              name: "خطأ في العملية رقم #{header_data['م'][j]} {المندوب}",
              error: delegate.errors.full_messages.join(', ')
            }
          else
            delegate_id = delegate.id
          end
        end

        if marketer_id.nil?
          marketer = Marketer.create(name: header_data['اسم المسوق'][j], city: header_data['المنطقة'][j])
          if marketer.invalid?
            result[:failed] << {
              name: "خطأ في العملية رقم #{header_data['م'][j]}{المسوق}",
              error: marketer.errors.full_messages.join(', ')
            }
          else
            marketer_id = marketer.id
          end
        end

        if operation_numbers.include?(header_data['م'][j])
          operation = SalesOperation.find_by(operation_number: header_data['م'][j])
          operation.update(
            commodity_amount: header_data['الكمية'][j],
            commodity_type: header_data['صنف'][j],
            date: header_data['التاريخ'][j],
            delegate_commission: header_data['عمولة المندوب'][j],
            from_delegate_transfer: header_data['تحويلات من المندوب'][j],
            marketer_commission: header_data['عمولة المسوق'][j],
            operation_number: header_data['م'][j],
            price: header_data['القيمة'][j],
            to_manger_transfer: header_data['تحويلات للمدير'][j],
            to_marketer_transfer: header_data['تحويلات للمسوق'][j],
            delegate_id: delegate_id,
            manger_id: manager_id,
            marketer_id: marketer_id
          )
        else
          operation = SalesOperation.create(
            commodity_amount: header_data['الكمية'][j],
            commodity_type: header_data['صنف'][j],
            date: header_data['التاريخ'][j],
            delegate_commission: header_data['عمولة المندوب'][j],
            from_delegate_transfer: header_data['تحويلات من المندوب'][j],
            marketer_commission: header_data['عمولة المسوق'][j],
            operation_number: header_data['م'][j],
            price: header_data['القيمة'][j],
            to_manger_transfer: header_data['تحويلات للمدير'][j],
            to_marketer_transfer: header_data['تحويلات للمسوق'][j],
            delegate_id: delegate_id,
            manger_id: manager_id,
            marketer_id: marketer_id
          )
        end

        if operation.invalid?
          result[:failed] << {
            name: "خطأ في العملية رقم #{header_data['م'][j]}",
            error: operation.errors.full_messages.join(', ')
          }
        end
      end
    end
    result
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename).downcase
      when ".csv" then  Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then  Roo::Excel.new(file.path, {file_warning: :ignore})
      when ".xlsx" then  Roo::Excelx.new(file.path, {file_warning: :ignore})
      else
        raise UnknownFileFormat
    end
  end

  def columns_data(sheet, header, key)
    index = header.index(key)
    data = []
    (3..sheet.last_row).each do |i|
      data << sheet.row(i)[index]
    end
    data
  end
end