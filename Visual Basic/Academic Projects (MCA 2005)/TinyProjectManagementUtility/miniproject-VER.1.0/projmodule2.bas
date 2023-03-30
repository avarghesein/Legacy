Attribute VB_Name = "projmodule2"

Option Explicit


Public Sub deleteall()
Dim X As New Connection
Set X = dn.cn
If X.State = 0 Then X.Open
 
 X.Execute "delete from subtasksassignedto "
 X.Execute "delete from projectsassignedto "
 X.Execute "delete from predecessortasks"
 X.Execute "delete  from successortasks"
 X.Execute "delete  from projectinprogress"
 X.Execute "delete  from passwordstore"
 X.Execute "delete from register"
 X.Execute "delete  from subtasks"
 X.Execute "delete  from projects"
 X.Execute "delete from person"
End Sub

Public Function deletetrigger(prjcde As Long, sure As Boolean) As Boolean
On Error GoTo errs
Dim tmp As New Connection
    If Not sure Then
        If MsgBox("ARE YOU SURE TO DELETE", vbOKCancel, "DELETE CONFIRM") = vbCancel Then
            deletetrigger = False
            Exit Function
         End If
    End If

    Set tmp = dn.cn
    If tmp.State = adStateClosed Then tmp.Open
    tmp.BeginTrans
    
    tmp.Execute "delete from subtasksassignedto where projid=" & prjcde & ""
    tmp.Execute "delete from projectsassignedto where projid=" & prjcde & ""
    tmp.Execute ("delete from passwordstore where projid=" & prjcde & "")
    tmp.Execute ("delete from predecessortasks where projid=" & prjcde & "")
    tmp.Execute ("delete from successortasks where projid=" & prjcde & "")
    tmp.Execute ("delete from projectinprogress where projid=" & prjcde & "")
    tmp.Execute ("delete from subtasks where projid=" & prjcde & "")
    tmp.Execute ("delete from projects where projid=" & prjcde & "")
    
    tmp.CommitTrans
    deletetrigger = True
    Exit Function
errs:
    MsgBox Err.Description
    If tmp.State = 1 Then
        tmp.RollbackTrans
    End If
    deletetrigger = False
End Function



Public Function validuser(prjcde As Long, username As Long, pass As String) As Boolean
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset
    
    Set X = dn.cn
    If X.State = adStateClosed Then X.Open
    
    Set Y = X.Execute("select * from projects where(projid=" & prjcde & " and projmanager=" & username & " and deleted='F')")
    If Y.RecordCount <= 0 Then
        Y.Close
        validuser = False
        Exit Function
    End If
    Y.Close
    Y.Open "select projmanager,projpassword from passwordstore where projid=" & prjcde & "", X
    If Y.RecordCount <= 0 Or username <> Val(Y.Fields("projmanager")) Or pass <> Trim(Y.Fields("projpassword")) Then
        Y.Close
        validuser = False
        Exit Function
    End If
    validuser = True
    Exit Function
    
cancel:
     MsgBox Err.Description
     validuser = False
 
End Function



Public Function getmaxid(fld As String, tnam As String, pid As Long, pidselect As Boolean) As Long
On Error GoTo cancel
Dim X As New Connection
Dim rs As New Recordset

Set X = dn.cn
If X.State = adStateClosed Then X.Open

If pidselect = False Then
    rs.Open "select * from " & tnam & "", X
Else
    rs.Open "select * from " & tnam & " where projid=" & pid & "", X
End If

If rs.RecordCount <= 0 Then
    getmaxid = 1
Else
    rs.Close
    If pidselect = True Then
        rs.Open "select max(" & fld & ") as maxi from " & tnam & " where projid=" & pid & "", X
    Else
        rs.Open "select max(" & fld & ") as maxi from " & tnam & "", X
    End If
    rs.MoveFirst
    getmaxid = (rs.Fields("maxi") + 1)
End If
Exit Function

cancel:
    MsgBox Err.Description
    getmaxid = 0
    
End Function


Public Function addtoprojects(id As Long, nam As String, desc As String, sdate As Date, man As Long, pass1 As String) As Boolean
On Error GoTo cancel
Dim X As New Connection

Set X = dn.cn
If X.State = adStateClosed Then X.Open


X.Execute "insert into projects(projid,projname,projdesc,projduration," _
 & "projstartdate,projmanager,completed,deleted) values(" & id & ",'" & nam & "','" & desc & _
 "',null,'" & Format$(Str(sdate), "dd-mmm-yyyy") & "'," & man & ",'F','F')"
 


X.Execute "insert into passwordstore(projid,projmanager,projpassword) values(" & id & "," & man & ",'" & pass1 & "')"
X.Execute "insert into projectsassignedto(personid,projid,assigneddate,status) values" _
       & "(" & man & "," & id & ",'" & Format$(Str(sdate), "dd-mmm-yyyy") & "','I')"
       

addtoprojects = True
Exit Function

cancel:
    addtoprojects = False
    MsgBox Err.Description

End Function

Public Function insubtasks(id As Long, nam As String, tabl As String) As Boolean
On Error GoTo cancel
Dim X  As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = adStateClosed Then X.Open
Y.Open "select * from " & tabl & " where (projid=" & id & " and " _
    & "taskname='" & nam & "')", X
    
If Y.RecordCount > 0 Then
    insubtasks = True
Else
    insubtasks = False
End If

Exit Function

cancel:
    MsgBox Err.Description
    insubtasks = False
End Function


Public Function addtosubtasks(tid As Long, pid As Long, tnam As String, tdesc As String, tdur As Long, tman As Long) As Boolean
On Error GoTo cancel
Dim X As New Connection

    Set X = dn.cn
    If X.State = adStateClosed Then X.Open
    
    X.Execute ("insert into subtasks(taskid,projid,taskname,taskdesc,taskduration," _
     & "taskearly,tasklate,taskmanager) values (" & tid & "," _
     & pid & ",'" & tnam & "','" & tdesc & "'," & tdur & ",null,null," & tman & ")")
     
    
     X.Execute ("insert into projectinprogress(taskid,projid,startdate,enddate)" _
      & " values(" & tid & "," & pid & ",null,null)")
      
         
     addtosubtasks = True
     Exit Function
cancel:
    
    MsgBox Err.Description
    addtosubtasks = False
    
End Function


Public Function deletefromsubtasks(pid As Long, tnam As String, tid As Long) As Boolean
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

    Set X = dn.cn
    If X.State = adStateClosed Then X.Open
   
   
    X.Execute ("delete from projectinprogress where (projid=" _
      & pid & " and taskid=" & tid & ")")
    
    X.Execute "delete from subtasksassignedto where(projid=" & pid & " and taskid=" & tid & ")"
    
    X.Execute ("delete from subtasks where (projid=" _
      & pid & " and taskname='" & tnam & "')")
     
    X.Execute "delete from register where(projid=" & pid & " and taskid=" & tid & ")"
    
    deletefromsubtasks = True
     Exit Function
cancel:
    
    MsgBox Err.Description
    deletefromsubtasks = False
    
End Function




Public Function add_to_predsucc(pid As Long, tid As Long, predsucc As Long, nullflg As Boolean, table As String)
On Error GoTo cancel
Dim X As New Connection

Set X = dn.cn
If X.State = adStateClosed Then X.Open


If nullflg = True Then
    X.Execute ("insert into " & table & "(taskid,projid,taskrelated) " _
    & "values(" & tid & "," & pid & ",null)")
Else
    X.Execute ("insert into " & table & "(taskid,projid,taskrelated) " _
    & "values(" & tid & "," & pid & "," & predsucc & ")")
End If


Exit Function
cancel:
    MsgBox Err.Description
    
End Function



Public Function valid_admin(name As String, pass As String) As Boolean
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

Set Y = X.Execute("select * from admins")

If Y.BOF And Y.EOF Then
    If name = "registernumbers" And pass = "[22525][84123]" Then
            valid_admin = True
    Else
            MsgBox "You Are Running The Scheduler For The First Time," & vbCrLf & _
            "Since It Registred." & vbCrLf & "No ADMINISTRATORS For The Product." & vbCrLf & _
            "So Enter The name & Password provided by PROJECT-SCHEDULER-SOFTWARE  And Retry", vbOKOnly, "NO ADMINISTRATORS!!!"
            valid_admin = False
    End If
Exit Function
End If

Set Y = X.Execute("select * from admins where(name='" & name _
      & "' and pass='" & pass & "')")

If (Y.BOF And Y.EOF) Then
    valid_admin = False
Else
    valid_admin = True
End If

Exit Function

cancel:
    MsgBox Err.Description
    valid_admin = False

End Function

Public Function isexsist(tnam As String, field As String, id As Long) As Boolean
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open
Set Y = X.Execute("select * from " & tnam & " where( " & field & "=" & id & " and exsist='T')")

If Y.RecordCount <= 0 Then
    isexsist = False
Else
    isexsist = True
End If

Exit Function

cancel:
    MsgBox Err.Description
    isexsist = False
End Function


