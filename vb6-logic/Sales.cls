VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Sales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Public Function GetCustomers(connectionString As String) As String

On Error GoTo catch

    Dim c As ADODB.Connection
    Dim r As ADODB.Recordset
    Dim cmd As ADODB.Command
    Dim ex As String
    
    Dim realConnectionString As String
    realConnectionString = "Provider=SQLOLEDB.1;" & connectionString
    
    Set c = New ADODB.Connection
    c.connectionString = realConnectionString
    c.Open
    
    Set cmd = New ADODB.Command
    Set cmd.ActiveConnection = c
    
    Dim num As Integer
    num = 0
    
    cmd.CommandText = "SELECT count(*) FROM [SalesLT].[Customer]"
    Set r = cmd.Execute()
    While Not r.EOF
        num = CInt(r(0))
    
        r.MoveNext
    Wend
    
    r.Close
    Set r = Nothing
    
    ReDim arr(num) As String
    
    cmd.CommandText = "" & _
    "SELECT CustomerID, FirstName, LastName " & _
    "FROM SalesLT.Customer"
    
    Set r = cmd.Execute()
    Dim i As Integer
    i = 1
    While Not r.EOF
        Dim s As String
        s = "{ ""CustomerID"":""" + CStr(r(0)) & """, ""FirstName"":""" + CStr(r(1)) + """, ""LastName"":""" + CStr(r(2)) + """ }"
        
        arr(i) = s
        i = i + 1
        r.MoveNext
    Wend
    
    r.Close
    Set r = Nothing
    
    Dim retVal As String
    
    retVal = "[" + Join(arr, ",") + "]"


finally:

    'clean up
    If Not r Is Nothing Then
        r.Close
    End If
    
    Set r = Nothing
    
    Set cmd = Nothing
    
    If Not c Is Nothing Then
        If c.State = adStateOpen Then
            c.Close
        End If
    End If
    
    Set c = Nothing
    
    GetCustomers = retVal

On Error GoTo 0
    If ex <> "" Then
        Err.Raise -1, , ex
    End If

    Exit Function

catch:
    Debug.Print Err.Description
    ex = "Error #" & Err.Number & ": '" & Err.Description & "' from '" & Err.Source & "'"
    
    Resume finally


End Function
