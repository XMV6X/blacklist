Here's the Microsoft Access VBA code to filter the data from the AutoTable and insert the results into the Blacklist table:

```vb
Sub FilterAutoTable()
    Dim db As DAO.Database
    Dim rsAutoTable As DAO.Recordset
    Dim rsBlacklist As DAO.Recordset
    
    ' Open the database and the AutoTable table
    Set db = CurrentDb()
    Set rsAutoTable = db.OpenRecordset("AutoTable")
    
    ' Create the Blacklist table if it doesn't exist
    If Not db.TableDefs.Exists("Blacklist") Then
        Set rsBlacklist = db.CreateTableDef("Blacklist")
        rsBlacklist.Fields.Append "PartNumber", dbText
        rsBlacklist.Fields.Append "BundleNumber", dbText
        rsBlacklist.Fields.Append "Bza", dbText
        rsBlacklist.Fields.Append "Werke", dbText
        rsBlacklist.Fields.Append "CommonUsage", dbText
        rsBlacklist.Fields.Append "SingleUsage", dbText
        db.TableDefs.Append rsBlacklist
    End If
    
    ' Set the Blacklist table
    Set rsBlacklist = db.OpenRecordset("Blacklist")
    
    ' Loop through the AutoTable records
    While Not rsAutoTable.EOF
    
        ' Check for 'fl' or 'fv' in Werke
        If InStr(rsAutoTable!Werke, "fl") <> 0 Or InStr(rsAutoTable!Werke, "fv") <> 0 Then
            ' Insert into Blacklist with Werke as CommonUsage
            With rsBlacklist
                .AddNew
                !PartNumber = rsAutoTable!PartNumber
                !BundleNumber = rsAutoTable!BundleNumber
                !Bza = rsAutoTable!Bza
                