class DocsFile

  attr_accessor :id, :name, :data

  def self.get(id)
    c = ActiveRecord::Base.connection
    query = <<-query
        SELECT
          cardfile.InstanceID,
          cardfile.FileName,
          binaries.Data
        FROM
          [dvtable_{B4562DF8-AF19-4D0F-85CA-53A311354D39}] cardfile WITH(NOLOCK)
          JOIN [dvtable_{2FDE03C2-FF87-4E42-A8C2-7CED181977FB}] fileversionmain WITH(NOLOCK)
            ON fileversionmain.InstanceID = cardfile.FileID
          JOIN [dvtable_{F831372E-8A76-4ABC-AF15-D86DC5FFBE12}] fileversion WITH(NOLOCK)
            ON fileversion.RowID = fileversionmain.currentid
          JOIN [dvsys_files] filedata WITH(NOLOCK)
            ON filedata.fileid = fileversion.fileid
          JOIN [dvsys_binaries] binaries WITH(NOLOCK)
            ON binaries.ID = filedata.BinaryID
        WHERE
          cardfile.InstanceID = '#{id}'
      query
    result = c.select_all(query).first
    return nil if result.nil?
    file = DocsFile.new
    file.id = result["InstanceID"]
    file.name = result["FileName"]
    file.data = result["Data"]
    return file
  end
end