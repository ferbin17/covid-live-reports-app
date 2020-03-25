class AddAdminUserToStatsReport < ActiveRecord::Migration[6.0]
  def change
    add_reference :stats_reports, :admin_user
  end
end