class Incident
  def initialize(data)
    @data = data
  end

  def created_date_string
    created_date.strftime('%-m/%-d/%Y')
  end

  def created_date
    created_time.to_date
  end

  def created_time
    Time.strptime(@data['created_on'], '%Y-%m-%dT%H:%M:%SZ')
  end

  def assigned_user
    @data['assigned_user'] || 'No one assigned'
  end

  def method_missing(method, *args, &block)
    if field = @data[method.to_s]
      field
    else
      super
    end
  end
end
