class AddStoredProceduresToTest < ActiveRecord::Migration
  def change
    if Rails.env.test?
      install_dv_reports("card-defs/IFP/IFPCardLib.xml")
    end
  end
end
