Attribute VB_Name = "projmodule3"

Option Explicit

Public Sub nosucc_earlylatestarts_settings(pid As Long)

On Error GoTo cancel

Dim i As Integer
Dim X As New Connection
Dim y1 As New Recordset
Dim y2 As New Recordset
Dim comb As ComboBox
Dim tmp_strng1 As String
Dim end_date1 As Date
Dim tmp_date1 As Date

Set X = dn.cn
If X.State = adStateClosed Then X.Open
X.Execute ("insert into successortasks(projid,taskid,taskrelated) " _
  & " select projid,taskid,null from subtasks where(" _
  & "projid=" & pid & " and taskid not in (select" _
  & " distinct(taskrelated) from predecessortasks where(" _
  & "projid=" & pid & " and taskrelated is not null)))")
  

Set comb = introduction.projnamecombo

tmp_strng1 = "select distinct(taskid)as tids from predecessortasks " _
             & "where(projid=" & pid & " and taskrelated is "
             
             
Set y1 = X.Execute(tmp_strng1 & "not null)")
Call addtocombobox(comb, y1, "tids")
y1.Close

X.Execute "update subtasks set taskearly='" _
  & Format$(Str(glob_proj.pstart), "dd-mmm-yyyy") & "' where(" _
  & "projid=" & pid & " and taskid in(" & tmp_strng1 & "null)))"
  


i = 0
While comb.ListCount > 0
    
   tmp_strng1 = "select distinct(taskrelated) from predecessortasks" _
               & " where(projid=" & pid & " and taskid=" & Val(comb.List(i)) & ")"
               
   Set y1 = X.Execute(tmp_strng1)
   Set y2 = X.Execute("select taskid from subtasks where(projid=" & pid & " and " _
            & "taskid in(" & tmp_strng1 & ") and taskearly is not null)")
              
    
    If y1.RecordCount <> y2.RecordCount Then
       i = i + 1
    Else
       y1.Close
       Set y1 = X.Execute("select taskearly as dates,taskduration as duration" _
              & " from subtasks where(projid=" & pid & " and taskid in(" & tmp_strng1 & "))")
              
       tmp_date1 = max_or_min_dateafteradd(y1, True, "dates", "duration")

       X.Execute ("update subtasks set taskearly='" _
         & Format$(Str(tmp_date1), "dd-mmm-yyyy") & "' where" _
         & "(projid=" & pid & " and taskid=" & Val(comb.List(i)) & ")")
         
       comb.RemoveItem (i)
    End If
    
    If i = comb.ListCount Then i = 0
    y1.Close
    y2.Close
Wend



Set y1 = X.Execute("select taskid as taskids,taskearly as early,taskduration as dur from " _
       & "subtasks where(projid=" & pid & " and taskid in(select distinct(taskid) from " _
       & "successortasks where(projid=" & pid & " and taskrelated is null)))")
       
       
end_date1 = max_or_min_dateafteradd(y1, True, "early", "dur")
glob_proj.pdur = Abs(DateDiff("d", end_date1, glob_proj.pstart))

X.Execute ("update projects set projduration=" & glob_proj.pdur & " where " _
           & "projid=" & pid & "")
           
y1.MoveFirst
While Not y1.EOF
  X.Execute ("update subtasks set tasklate='" & Format$(Str(DateAdd("d", -y1("dur"), end_date1)), "dd-mmm-yyyy") _
    & "' where (projid=" & pid & "and taskid=" & y1("taskids") & ")")
      
  y1.MoveNext
Wend

y1.Close
Set y1 = X.Execute("select taskid as tids,taskduration as dur from subtasks where" _
       & "(projid=" & pid & " and taskid in(select distinct(taskid) from " _
       & " successortasks where(projid=" & pid & "and taskrelated is not null)))")
       
       
Call addtocombobox_extended(comb, y1, "tids", "dur")
y1.Close
i = 0
While comb.ListCount > 0
   
   tmp_strng1 = "select distinct(taskrelated) from successortasks where(" _
         & "projid=" & pid & " and taskid=" & Val(comb.List(i)) & ")"
         
   Set y1 = X.Execute(tmp_strng1)
   Set y2 = X.Execute("select taskid from subtasks where(projid=" & pid & " and " _
          & "taskid in( " & tmp_strng1 & " )and tasklate is not null)")

   If y1.RecordCount <> y2.RecordCount Then
      i = i + 1
   Else
      y1.Close
      Set y1 = X.Execute("select tasklate as late from subtasks where" _
             & "(projid=" & pid & " and taskid in (" & tmp_strng1 & "))")
             
      tmp_date1 = max_or_min_date(y1, False, "late")
      
      X.Execute ("update subtasks set tasklate='" & Format$(DateAdd("d", -comb.ItemData(i), tmp_date1), "dd-mmm-yyyy") _
                & "' where(projid=" & pid & " and taskid=" & Val(comb.List(i)) & ")")
                
      comb.RemoveItem (i)
   End If
   
   If i = comb.ListCount Then i = 0
   
   y1.Close
   y2.Close
Wend

X.Execute "insert into subtasksassignedto(personid,projid,taskid,assigneddate,status)  " _
  & " select taskmanager,projid,taskid,taskearly,'I' from subtasks where projid=" & pid & ""

MsgBox "YOUR PROJECT SHEDULING COMPLETED" & vbCrLf & "PROJECT ID:" & glob_proj.pid & _
         vbCrLf & "EXPECTED DURATION OF PROJECT:" & Str(glob_proj.pdur) & " DAYS" & vbCrLf _
         & "PROJECT'S STARTING DATE:" & Format$(Str(glob_proj.pstart), "DD-MMM-YYYY") & vbCrLf _
         & "PROJECT'S EXPECTED ENDING DATE:" & Format$(Str(end_date1), "DD-MMM-YYYY") & vbCrLf & _
         "FOR MORE DETAILS USE THE VIEW OPTION FROM MENU", vbOKOnly, "PROJECT SHEDULE COMPLETE"
         
comb.clear

Exit Sub

cancel:
    MsgBox Err.Description
    comb.clear
End Sub



Public Function max_or_min_dateafteradd(Y As Recordset, maxflg As Boolean, dates As String, interval As String) As Date

On Error GoTo cancel

Dim sgnflg As Integer
Dim tmp1 As Date
Dim tmp2 As Date

If Y.State = 0 Or Y.RecordCount <= 0 Then
    MsgBox "AN ERROR OCCURED IN CALCULATING MAXIMUM DATE"
    Exit Function
End If

If maxflg = True Then sgnflg = 1 Else sgnflg = -1

Y.MoveFirst

tmp1 = DateAdd("d", sgnflg * Y(interval), DateValue(Y(dates)))

Y.MoveNext

While Not Y.EOF
  
  tmp2 = DateAdd("d", sgnflg * Y(interval), DateValue(Y(dates)))
  If maxflg Then
     If tmp2 > tmp1 Then tmp1 = tmp2
  Else
     If tmp2 < tmp1 Then tmp1 = tmp2
  End If
  Y.MoveNext
 
Wend
 
max_or_min_dateafteradd = tmp1

Exit Function

cancel:
  MsgBox Err.Description

End Function

Public Sub addtocombobox_extended(comb As ComboBox, rs As Recordset, f1 As String, f2 As String)
On Error GoTo cancel

comb.clear
If rs.RecordCount <= 0 Then Exit Sub
rs.MoveFirst
While Not rs.EOF
    comb.AddItem (Trim(rs.Fields(f1)))
    comb.ItemData(comb.NewIndex) = Val(rs.Fields(f2))
    rs.MoveNext
Wend
Exit Sub
cancel:
    MsgBox Err.Description
    
End Sub

Public Function max_or_min_date(Y As Recordset, maxflg As Boolean, f As String) As Date

Dim tmp1 As Date
Dim tmp2 As Date

If Y.State = 0 Or Y.RecordCount <= 0 Then
    MsgBox "AN ERROR OCCURED IN CALCULATING MAXIMUM DATE"
    Exit Function
End If

Y.MoveFirst


tmp1 = DateValue(Y(f))

Y.MoveNext

While Not Y.EOF
  
  tmp2 = DateValue(Y(f))
  If maxflg Then
     If tmp2 > tmp1 Then tmp1 = tmp2
  Else
     If tmp2 < tmp1 Then tmp1 = tmp2
  End If
  Y.MoveNext
 
Wend
 
max_or_min_date = tmp1
Exit Function

cancel:
  MsgBox Err.Description

End Function

Public Sub copycombolist_1to2(cntrl1 As Control, cntrl2 As Control, Optional clear_bucket1 As Boolean)

While cntrl1.ListCount > 0
        cntrl2.AddItem (cntrl1.List(0))
        cntrl2.ItemData(cntrl2.NewIndex) = cntrl1.ItemData(0)
        If Not IsMissing(clear_bucket1) And clear_bucket1 Then
            cntrl1.RemoveItem (0)
        End If
Wend
End Sub
