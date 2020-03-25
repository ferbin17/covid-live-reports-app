module ReportsHelper

    def district_name(district_id)
        District.find_by_id(district_id).name.capitalize
    end
end
