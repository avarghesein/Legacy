Attribute VB_Name = "projmodule4"


Option Explicit

Type projectinfo
    man As Long
    name As String
End Type

Type taskinfo
    taskid As Long
    man As Long
    name As String
End Type



Public Function isstartdatefixed(pid As Long, tid As Long, getstart As Date) As Boolean
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = adStateClosed Then X.Open
Set Y = X.Execute("select startdate as starts from projectinprogress" _
        & " where(projid=" & pid & " and taskid=" & tid & " and" _
        & " startdate is not null)")
        

If Y.RecordCount <= 0 Then
    isstartdatefixed = False
Else
    Y.MoveFirst
    getstart = DateValue(Y("starts"))
    isstartdatefixed = True
End If

Exit Function

cancel:
     MsgBox Err.Description
     isstartdatefixed = False

End Function


Public Function isallpredecessorscompleted(pid As Long, tid As Long, getend As Date) As Boolean
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = adStateClosed Then X.Open
Set Y = X.Execute("select distinct(taskrelated) from predecessortasks where(" _
       & "projid=" & pid & " and taskid=" & tid & " and taskrelated is not null and taskrelated not in(" _
       & "select distinct(taskrelated) from predecessortasks where(projid=" _
       & pid & " and taskid=" & tid & " and taskrelated is not null and taskrelated in(select taskid from" _
       & " projectinprogress where(projid=" & pid & " and enddate is not null)))))")

If Y.RecordCount > 0 Then
   isallpredecessorscompleted = False
Else
    Y.Close
    Set Y = X.Execute("select max(enddate) as  maxi  from projectinprogress" _
        & " where(projid=" & pid & " and taskid in(select distinct(taskrelated) from" _
        & " predecessortasks where(projid=" & pid & " and taskid=" & tid & ")))")
   
    Y.MoveFirst
    If IsNull(Y("maxi")) Then
        Y.Close
        Set Y = X.Execute("select projstartdate as maxi from projects where projid=" & pid & "")
    End If
    getend = DateValue(Y("maxi"))
    isallpredecessorscompleted = True

End If
Exit Function

cancel:
    MsgBox Err.Description
    isallpredecessorscompleted = False
End Function

Public Function isenddatefixed(pid As Long, tid As Long, getend As Date) As Boolean
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = adStateClosed Then X.Open
Set Y = X.Execute("select enddate as enddated from projectinprogress" _
        & " where(projid=" & pid & " and taskid=" & tid & " and" _
        & " enddate is not null)")
        

If Y.RecordCount <= 0 Then
    isenddatefixed = False
Else
    Y.MoveFirst
    getend = DateValue(Y("enddated"))
    isenddatefixed = True
End If

Exit Function

cancel:
     MsgBox Err.Description
     isenddatefixed = False

End Function

Public Function give_minimum_endate(pid As Long, tid As Long, minend As Date) As Boolean
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = adStateClosed Then X.Open

Set Y = X.Execute("select startdate as starts from projectinprogress where" _
       & "(projid=" & pid & " and taskid=" & tid & " and startdate is not null)")
       

Y.MoveFirst
If Y.RecordCount <= 0 Then
   give_minimum_endate = False
Else
   minend = DateValue(Y("starts"))
   Y.Close
   Set Y = X.Execute("select taskduration as dur from subtasks where" _
       & "(projid=" & pid & " and taskid=" & tid & ")")
       
   Y.MoveFirst
   minend = DateAdd("d", Y("dur"), minend)
   give_minimum_endate = True
End If

Exit Function

cancel:
     give_minimum_endate = False
     MsgBox Err.Description
End Function

Public Function statusofsubtask(pid As Long, tid As Long, _
         setdate As Date, dateprovided As Boolean, rtf As RichTextBox, toappend As Boolean) As Integer

On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset
Dim tmp As Boolean
Dim started As Date
Dim ended As Date
Dim maxpredend As Date
Dim expectedend As Date

Set X = dn.cn
If X.State = adStateClosed Then X.Open

Set Y = X.Execute("select * from subtasks where(projid=" & pid & " and taskid=" & tid & ")")
If Y.RecordCount <= 0 Then
    Y.Close
    Exit Function
End If

rtf.SelFontName = "courier new"
rtf.SelFontSize = 8
rtf.SelIndent = 500
rtf.SelHangingIndent = -250
rtf.SelRightIndent = 100
rtf.RightMargin = 20000
Y.MoveFirst

With rtf
 If toappend = True Then
        .Text = .Text & " "
 Else
        .Text = " "
 End If
 .Text = .Text & vbCrLf & "SUBTASK NAME IS:"
 Call formattextinrtf(rtf, findvalidstring(.Text), "courier new", 9)
 .Text = .Text & Trim(Y("taskname")) & "." & vbCrLf & vbCrLf
 .Text = .Text & "TASK MANAGER:" & vbCrLf
  Call printdetailsofperson(Val(Y("taskmanager")), rtf)
 .Text = .Text & vbCrLf & vbCrLf & "DESCRIPTION OF TASK" & vbCrLf & "-------------------" & vbCrLf
 .Text = .Text & Y("taskdesc") & vbCrLf & vbCrLf
 .Text = .Text & "ASSUMED INTERVAL FOR STARTING THE TASK:"
 .Text = .Text & "from " & Format$(Y("taskearly"), "dd-mmm-yyyy") _
 & " to " & Format$(Y("tasklate"), "dd-mmm-yyyy") & "." & vbCrLf & vbCrLf & "ASSUMED DURATION:" _
 & Y("taskduration") & "." & vbCrLf
 
End With

With rtf
      .Text = .Text & vbCrLf & vbCrLf & "        ACTUAL STARTING STATUS" & vbCrLf & vbCrLf
End With

If Not isstartdatefixed(pid, tid, started) Then
     If Not isallpredecessorscompleted(pid, tid, maxpredend) Then
        With rtf
          .Text = .Text & "The task cannot start now,because some of its predecessors not completed." & vbCrLf
        End With
        statusofsubtask = 0
        Exit Function
    Else
        If Not dateprovided Then
            With rtf
                .Text = .Text & "The task can start now." & vbCrLf
            End With
            statusofsubtask = 1
            Exit Function
        Else
            If setdate < maxpredend Then
                With rtf
                    .Text = .Text & "Process cant start in the date given by " & Format$(Str(setdate), "dd-mmm-yyyy") & "." & vbCrLf & _
                     "Because some of the predecessors are not completed yet." & vbCrLf
                End With
                statusofsubtask = 2
                Exit Function
            Else
                Call compare_with_tasklate(pid, tid, rtf, setdate)
                 If X.State = 0 Then X.Open
                 X.Execute ("update projectinprogress set startdate='" & Format$(Str(setdate), "dd-mmm-yyyy") & _
                  "' where(projid=" & pid & " and taskid=" & tid & ")")
                  
                statusofsubtask = 3
                Exit Function
            End If
        End If
    End If
Else
    Call compare_with_tasklate(pid, tid, rtf, started)
    With rtf
      .Text = .Text & vbCrLf & vbCrLf & "        ACTUAL ENDING STATUS" & vbCrLf & vbCrLf
    End With
    If Not isenddatefixed(pid, tid, ended) Then
        If Not dateprovided Then
            statusofsubtask = 4
            With rtf
                .Text = .Text & "The task is not ended yet,It is on Progress." & vbCrLf
            End With
            Exit Function
        Else
            tmp = give_minimum_endate(pid, tid, expectedend)
            If setdate < expectedend Then
                With rtf
                    .Text = .Text & "The task can't stop now," & vbCrLf & "The minimum time for completion is not reached." & vbCrLf
                End With
                statusofsubtask = 5
                Exit Function
            Else
                Call compare_with_duration(pid, tid, setdate, rtf)
                If X.State = 0 Then X.Open
                X.BeginTrans
                X.Execute ("update projectinprogress set enddate='" & Format$(Str(setdate), "dd-mmm-yyyy") _
                 & "' where (projid=" & pid & " and taskid=" & tid & ")")
                
                X.Execute "update subtasksassignedto set status='C' where(projid=" & pid _
                 & " and taskid=" & tid & " and personid=(select taskmanager from subtasks where(" _
                 & "projid=" & pid & " and taskid=" & tid & ")))"
                
                X.CommitTrans
                Set Y = X.Execute("select taskid from subtasks where(projid=" & pid & " and taskid not in" _
                & "(select taskid from projectinprogress where(projid=" & pid & " and enddate is" _
                & " not null)))")

                If Y.RecordCount <= 0 Then
                    X.BeginTrans
                    X.Execute "update projects set completed='T' where projid=" & pid & ""
                    X.Execute "update projectsassignedto set status='C' where(projid=" & pid _
                    & " and personid=(select projmanager from projects where projid=" & pid & "))"
                    X.CommitTrans
                End If
                
                statusofsubtask = 6
        
                Exit Function
            End If
        End If
    Else
        Call compare_with_duration(pid, tid, ended, rtf)
        statusofsubtask = 7
        End If
End If
Exit Function

cancel:
     statusofsubtask = 8
     MsgBox Err.Description
End Function

Public Sub formattextinrtf(rtf As RichTextBox, strg As String, fnt As String, sze As Integer)

With rtf
 .SelStart = 0
 .SelStart = .Find(strg)
 .Span (strg)
 .SelColor = RGB(50, 50, 170)
 .SelFontName = "courier new"
 .SelFontSize = 9
End With
End Sub


Public Sub compare_with_tasklate(pid As Long, tid As Long, rtf As RichTextBox, setdate As Date)
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset
Dim tmp As Date
Dim tmp_num As Integer

Set X = dn.cn
If X.State = adStateClosed Then X.Open

Set Y = X.Execute("select taskname from subtasks where(projid=" & pid & " and taskid=" & tid & ")")
Y.MoveFirst
glob_task.tnam = Trim(Y("taskname"))
Y.Close

Set Y = X.Execute("select tasklate as late from subtasks where(projid=" & pid & " and taskid=" & tid & ")")
If Y.RecordCount <= 0 Then
  With rtf
    .Text = .Text & "Late start not set for this task" & vbCrLf
  End With
  Exit Sub
End If

With rtf
    .Text = .Text & "The task started on " & Format$(Str(setdate), "dd-mmm-yyyy") & "." & vbCrLf
End With

Y.MoveFirst
tmp = DateValue(Y("late"))
If setdate > tmp Then
    With rtf
        .Text = .Text & "The task is started late by " & Str(Abs(DateDiff("d", tmp, setdate))) & _
          " Days from its expected start date(Late Start)." & vbCrLf _
          & "This will cause a delay in the project."
    End With
    Y.Close
    Set Y = X.Execute("select max(enddate) as edate from projectinprogress where(projid=" _
           & pid & " and taskid in(select distinct(taskrelated) from predecessortasks where" _
           & "(projid=" & pid & " and taskid=" & tid & " and taskrelated is not null)))")
    If Y.RecordCount > 0 And Not IsNull(Y("edate")) Then
        Y.MoveFirst
        With rtf
            tmp_num = Str(Abs(DateDiff("d", DateValue(Format$(Y("edate"), "mm/dd/yyyy")), setdate)))
            If tmp_num > 0 Then
                    .Text = .Text & vbCrLf & "The task " & glob_task.tnam & " is started late by " _
                           & Str(Abs(DateDiff("d", DateValue(Format$(Y("edate"), "mm/dd/yyyy")), setdate))) & " days," _
                           & vbCrLf & "From the completion date of it's last predecessor completed."
                     .Text = .Text & vbCrLf & "Task " & glob_task.tnam & " is fully responsible for this."
            Else
                    .Text = .Text & vbCrLf & "The task " & glob_task.tnam & " is started immediatley " & _
                             "after it's Last Predecessor completed." & vbCrLf & "So that the task started " & _
                           "without any delay after it's predecessors completed." & vbCrLf & "If it's assumed startdate is changed it's due to it's " & _
                           "predecessors."
            End If
        End With
    Else
        Y.Close
        Set Y = X.Execute("select projstartdate as strt from projects where projid=" & pid & "")
        Y.MoveFirst
        With rtf
            .Text = .Text & vbCrLf & "The task is a initial task with no predecessors." & vbCrLf
            .Text = .Text & "The task itself started late by " & Str(Abs(DateDiff("d", CDate(Format$(Y("strt"), "mm/dd/yyyy")), setdate))) _
                  & " days from the startdate the project."
            .Text = .Text & vbCrLf & "Task " & glob_task.tnam & " is fully responsible for this."
        End With
    End If
    
Else
    With rtf
        .Text = .Text & "The task started properly with in the interval expected." & vbCrLf
    End With
  
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub

Public Sub compare_with_duration(pid As Long, tid As Long, ended As Date, rtf As RichTextBox)
On Error GoTo cancel

Dim started As Date
Dim dur, adur As Long
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = adStateClosed Then X.Open

With rtf
    .Text = .Text & "The task ended on " & Format$(Str(ended), "dd-mmm-yyyy") & "." & vbCrLf
End With

Set Y = X.Execute("select taskduration as dur from subtasks where(projid=" & pid & " and taskid=" & tid & ")")
Y.MoveFirst
dur = Y("dur")
Y.Close
Set Y = X.Execute("select startdate as starts from projectinprogress where(projid=" & pid & "and taskid=" & tid & ")")
Y.MoveFirst
started = DateValue(Y("starts"))
adur = Abs(DateDiff("d", started, ended))
If adur > dur Then
    With rtf
        .Text = .Text & "The task took additional " & Str(adur - dur) & " days," & vbCrLf _
           & "for completion compared to the expected duration " & Str(dur) & "." & vbCrLf _
           & "That is the task took " & Str(adur) & " days for completion."
    End With
Else
    With rtf
        .Text = .Text & "The task completed properly," _
             & "It took only the expected duration of " & Str(adur) & " days." & vbCrLf
    End With
End If

Exit Sub

cancel:
    MsgBox Err.Description

End Sub

Public Function compare_task_with_preds(pid As Long, tid As Long, predid As Long, rtf As RichTextBox) As Boolean

On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset
Dim tstrt As Date
Dim pnam As String
Dim pman As String
Dim pend As Date

Set X = dn.cn
If X.State = 0 Then X.Open

rtf.SelFontName = "courier new"
rtf.SelFontSize = 11
rtf.SelIndent = 500
rtf.SelHangingIndent = -250
rtf.SelRightIndent = 100
rtf.RightMargin = 20000

Set Y = X.Execute("select taskmanager as man,taskname as nam,taskearly as early,tasklate as late " _
      & "from subtasks where(projid=" & pid & " and taskid=" & tid & ")")

Y.MoveFirst
With glob_task
     .tmanager = Trim(Y("man"))
     .tnam = Trim(Y("nam"))
     .t_estart = DateValue(Y("early"))
     .t_lstart = DateValue(Y("late"))
     .tid = tid
End With

Y.Close

Set Y = X.Execute("select taskname as nam,taskmanager as man from subtasks" _
       & " where(projid=" & pid & " and taskid=" & predid & ")")
       
Y.MoveFirst
pnam = Trim(Y("nam"))
pman = Trim(Y("man"))

Y.Close
Set Y = X.Execute("select enddate as endte from projectinprogress where(" _
      & "projid=" & pid & " and taskid=" & predid & ")")
      

Y.MoveFirst
pend = DateValue(Y("endte"))

Y.Close
Set Y = X.Execute("select startdate as strt from projectinprogress where(" _
      & "projid=" & pid & " and taskid=" & tid & ")")

Y.MoveFirst
tstrt = DateValue(Y("strt"))

Y.Close

With rtf
    .Text = " " & vbCrLf & "EFFECT OF PREDECESSOR TASK " & pnam & " ON TASK " & glob_task.tnam & vbCrLf
     Call formattextinrtf(rtf, findvalidstring(.Text), "courier new", 9)
End With

If tstrt > pend Then
    With rtf
        .Text = .Text & vbCrLf & vbCrLf & "        STARTING STATUS OF " & glob_task.tnam & vbCrLf
        .Text = .Text & vbCrLf & "The task " & glob_task.tnam & " itself started  delayed " & Str(Abs(DateDiff("d", tstrt, pend))) _
            & " Days After the ending of the task " & pnam & "." & vbCrLf & "Task " & glob_task.tnam & " is" _
            & " fully responsible for this delay." & vbCrLf
        Call printdetailsofperson(Val(glob_task.tnam), rtf)
    
    End With
End If

With rtf
    .Text = .Text & vbCrLf & vbCrLf & "        AFFECT ON SLACK TIME OF " & glob_task.tnam & vbCrLf & vbCrLf
    .Text = .Text & "The actual Total-Slack of task " & glob_task.tnam & " is " & Str( _
    Abs(DateDiff("d", glob_task.t_estart, glob_task.t_lstart))) & " days."
End With

If pend > glob_task.t_estart Then
    With rtf
        If pend <= glob_task.t_lstart Then
            .Text = .Text & vbCrLf & "The predecessor task " & pnam & " reduced the Total-Slack to " & _
              Str((DateDiff("d", pend, glob_task.t_lstart))) & " days."
        Else
            .Text = .Text & vbCrLf & "The predecessor task " & pnam & " itself will cause a minimum delay," & vbCrLf & "of " & _
              Trim(Str(Abs((DateDiff("d", pend, glob_task.t_lstart))))) & " days in the assumed starting date of the task " & glob_task.tnam & "."
              
        End If
    End With
End If

With rtf
    .Text = .Text & vbCrLf & vbCrLf & "        CONCLUSION" & vbCrLf & vbCrLf
End With

If pend <= glob_task.t_lstart Then
    With rtf
        .Text = .Text & "The predecessor task " & pnam & " does not affected the task " & glob_task.tnam & " Adversly," & vbCrLf _
             & "That is its expected late start " & Format$(Str(glob_task.t_lstart), "dd-mmm-yyyy") & "," & vbCrLf & "Is not altered due to the ending date of task " & pnam & "."
    End With

Else
    With rtf
        .Text = .Text & "The task " & pnam & " have a Adverse effect on the task " & glob_task.tnam & "," & vbCrLf _
        & "Because the Late-Start of task " & glob_task.tnam & " is altered from," & vbCrLf & "the actual late-start " _
        & Format$(Str(glob_task.t_lstart), "dd-mmm-yyyy") & " to the date " & Format$(Str(pend), "dd-mmm-yyyy") & "." & vbCrLf _
        & "That is the task " & glob_task.tnam & " have to start with a delay of " & Str(Abs(DateDiff("d", pend, glob_task.t_lstart))) & "," & _
        vbCrLf & "Due to the task " & pnam & ",irrespect to the task " & glob_task.tnam & "."
     End With
End If


With rtf
    .Text = .Text & vbCrLf & vbCrLf & "        MANAGER OF PREDECESSOR TASK " & pnam & vbCrLf & vbCrLf
    Call printdetailsofperson(Val(pman), rtf)
End With

Exit Function

cancel:
    MsgBox Err.Description
End Function

Public Function compare_task_with_succs(pid As Long, tid As Long, succid As Long, rtf As RichTextBox) As Boolean
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset

Dim nam As String
Dim man As String
Dim tend As Date

Set X = dn.cn
If X.State = 0 Then X.Open

rtf.SelFontName = "courier new"
rtf.SelFontSize = 11
rtf.SelIndent = 500
rtf.SelHangingIndent = -250
rtf.SelRightIndent = 100
rtf.RightMargin = 20000

Set Y = X.Execute("select taskname as nam,taskearly as early,tasklate as late " _
      & "from subtasks where(projid=" & pid & " and taskid=" & succid & ")")

Y.MoveFirst
With glob_task
     .tnam = Trim(Y("nam"))
     .t_estart = DateValue(Y("early"))
     .t_lstart = DateValue(Y("late"))
     .tid = succid
End With

Set Y = X.Execute("select taskname as nam,taskmanager as man from subtasks" _
       & " where(projid=" & pid & " and taskid=" & tid & ")")
       
Y.MoveFirst
nam = Trim(Y("nam"))
man = Trim(Y("man"))

Y.Close
Set Y = X.Execute("select enddate as endte from projectinprogress where(" _
      & "projid=" & pid & " and taskid=" & tid & ")")
      

Y.MoveFirst
tend = DateValue(Y("endte"))


With rtf
    .Text = " " & vbCrLf & "EFFECT OF TASK " & nam & " ON SUCCESSOR TASK " & glob_task.tnam & vbCrLf & vbCrLf & vbCrLf
     Call formattextinrtf(rtf, findvalidstring(.Text), "courier new", 9)
End With


With rtf
    .Text = .Text & "     SLACK TIME EVALUATION OF SUCCESSOR TASK " & Trim(glob_task.tnam)
    .Text = .Text & vbCrLf & vbCrLf & "The actual Total-Slack of successor task " & Trim(glob_task.tnam) & " is " & Str( _
    Abs(DateDiff("d", glob_task.t_estart, glob_task.t_lstart))) & " days."
End With

If tend > glob_task.t_estart Then
    With rtf
        If tend <= glob_task.t_lstart Then
              .Text = .Text & vbCrLf & "The task " & nam & " reduced the Total-Slack of successor " & glob_task.tnam & " to " _
              & Str((DateDiff("d", tend, glob_task.t_lstart))) & " days."
        Else
              .Text = .Text & vbCrLf & "The task " & nam & " itself will cause a minimum delay of " & _
              Str(Abs((DateDiff("d", tend, glob_task.t_lstart)))) & " days in," & vbCrLf & _
              "the assumed starting date of the task " & glob_task.tnam & "."
        End If
    End With
End If

With rtf
    .Text = .Text & vbCrLf & vbCrLf & "     CONCLUSION" & vbCrLf & vbCrLf
End With

If tend <= glob_task.t_lstart Then
    With rtf
        .Text = .Text & "The task " & Trim(nam) & " does not affected the successor task " & glob_task.tnam & " Adversly," & vbCrLf _
             & "That is its expected late start " & Format$(Str(glob_task.t_lstart), "dd-mmm-yyyy") & "," & vbCrLf & "Is not altered due to the ending date of task " & Trim(nam) & "."
    End With
Else
    With rtf
        .Text = .Text & "The task " & Trim(nam) & " have a Adverse effect on the successor task " & glob_task.tnam & "," & vbCrLf _
        & "Because the Late-Start of task " & glob_task.tnam & " is altered from," & vbCrLf & "the actual late-start " _
        & Format$(Str(glob_task.t_lstart), "dd-mmm-yyyy") & " to the date " & Format$(Str(tend), "dd-mmm-yyyy") & "." & vbCrLf _
        & "That is the task " & glob_task.tnam & " have to start with a delay of " & Str(Abs(DateDiff("d", tend, glob_task.t_lstart))) & " days," & _
        vbCrLf & "Due to the task " & Trim(nam) & ",irrespect to the task " & glob_task.tnam & "."
     End With
End If

With rtf
 .Text = .Text & vbCrLf & vbCrLf & "     MANAGER OF THE TASK " & nam & vbCrLf & vbCrLf
 Call printdetailsofperson(Val(man), rtf)
End With

Exit Function

cancel:
    MsgBox Err.Description

End Function


Public Function findvalidstring(X As String) As String

Dim I As Integer
Dim tmp As String

If Len(X) = 0 Then
    findvalidstring = ""
    Exit Function
End If

I = 1
tmp = Left(X, 2)

While Len(tmp) > 0 And tmp = vbCrLf
    I = I + 2
    tmp = Mid(X, I, 2)
Wend

findvalidstring = Left(tmp, 1)

End Function

Public Function project_report(pid As Long, rtf As RichTextBox) As Boolean
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset
Dim comb As ComboBox
Dim y1 As New Recordset
Dim I As Integer
Dim j As Integer
Dim k As Integer
Dim pstrt As Date


Set comb = introduction.projidcombo

Set X = dn.cn
If X.State = adStateClosed Then X.Open

Set Y = X.Execute("select projname as nam,projmanager as pman,projdesc as pdesc," _
      & "projstartdate as strt,projduration as pdur from projects where (projid=" & pid & ")")
      

pstrt = DateValue(Format(Y("strt"), "mm/dd/yyyy"))

rtf.SelIndent = 500
rtf.SelHangingIndent = -250
rtf.SelRightIndent = 100
rtf.RightMargin = 20000
Y.MoveFirst

With rtf
 .Text = " " & vbCrLf & "               PROJECT REPORT" & vbCrLf & "               **************" & vbCrLf & vbCrLf
 .Text = .Text & vbCrLf & "PROJECT NAME:"
 Call formattextinrtf(rtf, findvalidstring(.Text), "courier new", 10)
 .Text = .Text & Trim(Y("nam")) & "." & vbCrLf & vbCrLf
 .Text = .Text & "PROJECT MANAGER:" & vbCrLf
 Call printdetailsofperson(Val(Y("pman")), rtf)
 .Text = .Text & vbCrLf & vbCrLf & "DESCRIPTION OF PROJECT" & vbCrLf & "~~~~~~~~~~~~~~~~~~~~~~" & vbCrLf
 .Text = .Text & Y("pdesc") & vbCrLf & vbCrLf
 .Text = .Text & "EXPECTED STARTING DATE OF PROJECT:"
 .Text = .Text & Format$(Y("strt"), "dd-mmm-yyyy") & "." & vbCrLf & vbCrLf & "ASSUMED DURATION:" _
 & Y("pdur") & "." & vbCrLf & vbCrLf
    .Text = .Text & "**********************************************************************" & vbCrLf
End With

Set Y = X.Execute("select taskid as tid from subtasks where (projid=" & pid & ") order by taskearly")
Call addtocombobox(comb, Y, "tid")
j = 0
k = 1
While j <= comb.ListCount - 1
    
    With rtf
        .Text = .Text & "               SUBTASK NO:" & Str(k) & vbCrLf
         k = k + 1
    End With
    Call statusofsubtask(pid, Val(comb.List(j)), DateValue("01/01/0001"), False, rtf, True)
    If X.State = 0 Then X.Open
    Set y1 = X.Execute("select taskname from subtasks where(projid=" & pid _
           & " and taskid in(select distinct(taskrelated) from predecessortasks" _
           & " where(projid=" & pid & " and taskrelated is not null and taskid=" & Val(comb.List(j)) & "))) order by taskearly")
           
    If y1.RecordCount <= 0 Then
        With rtf
            .Text = .Text & vbCrLf & vbCrLf & "The task is a initial task."
        End With
    Else
        I = 1
        With rtf
            .Text = .Text & vbCrLf & vbCrLf & "THE IMMEDIATE PREDECESSORS OF THE TASK" & vbCrLf
             y1.MoveFirst
             While Not y1.EOF
                .Text = .Text & vbCrLf & Str(I) & ". " & Trim(y1("taskname"))
                 I = I + 1
                 y1.MoveNext
             Wend
        End With
    End If
        
    
    Set y1 = X.Execute("select taskname from subtasks s1,successortasks s2 where(s2.projid=" & pid _
           & " and s2.taskid=" & Val(comb.List(j)) & " and s2.taskrelated is not null and s1.projid=s2.projid and s1.taskid=s2.taskrelated) order by taskearly")
           
           
    If y1.RecordCount <= 0 Then
        With rtf
            .Text = .Text & vbCrLf & "The task is a Final task."
        End With
    Else
        I = 1
        With rtf
            .Text = .Text & vbCrLf & vbCrLf & "THE IMMEDIATE SUCCESSORS OF THE TASK" & vbCrLf
             y1.MoveFirst
             While Not y1.EOF
                .Text = .Text & vbCrLf & Str(I) & ". " & Trim(y1("taskname"))
                 I = I + 1
                 y1.MoveNext
             Wend
        End With
    End If

    
    With rtf
        .Text = .Text & vbCrLf & vbCrLf & "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^" & vbCrLf
    End With
    
    j = j + 1
Wend


With rtf
    .Text = .Text & vbCrLf & vbCrLf & "          PROJECT'S CURRENT STATUS"
    .Text = .Text & vbCrLf & "          ************************" & vbCrLf & vbCrLf
End With

Set Y = X.Execute("select max(enddate) as enddte from projectinprogress where(" _
        & "projid=" & pid & " and  enddate is not null)")

If Y.RecordCount <= 0 Or IsNull(Y("enddte")) Then
    With rtf
        .Text = .Text & "The Project is not started yet."
    End With
Else
    With rtf
        .Text = .Text & "The delay of Project uptto the current stage is " _
              & Str(Abs(DateDiff("d", pstrt, DateValue(Format(Y("enddte"), "mm/dd/yyyy"))))) _
              & " days."
    End With
End If


Set Y = X.Execute("select taskid from subtasks where(projid=" & pid & " and taskid not in" _
             & "(select taskid from projectinprogress where(projid=" & pid & " and enddate is" _
             & " not null)))")

With rtf
    If Y.RecordCount > 0 Then
        .Text = .Text & vbCrLf & "The project is not completed yet." & vbCrLf & vbCrLf
    Else
        .Text = .Text & vbCrLf & "The project is already completed." & vbCrLf & vbCrLf
    End If
End With

Exit Function

cancel:
    MsgBox Err.Description
End Function

Public Sub printdetailsofperson(id As Long, rtf As RichTextBox)
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

Set Y = X.Execute("select name,address,age,sex,remarks from person where id=" & id & "")

If Y.RecordCount <= 0 Then

    With rtf
        .Text = .Text & "Person with id " & Str(id) & " not exsists"
     End With
Else
    With rtf
        .Text = .Text & "          Personnel Id:" & Str(id) & "." & vbCrLf
        .Text = .Text & "          Name:" & Trim(Trim(Y("name"))) & "." & vbCrLf
        .Text = .Text & "          Age:" & Str(Abs(DateDiff("yyyy", DateValue(Format(Now, "mm/dd/yyyy")), _
                            DateValue(Format(Str(Y("age")), "mm/dd/yyyy"))))) & "." & vbCrLf
        .Text = .Text & "          Sex:" & Trim(Y("sex")) & vbCrLf
        .Text = .Text & "          Address" & vbCrLf & "               "
        Call printmultiline(Trim(Y("address")), rtf, 15)
        .Text = .Text & "          Remarks" & vbCrLf & "               "
        Call printmultiline(Trim(Y("remarks")), rtf, 15)
    End With
End If

Exit Sub
cancel:
    MsgBox Err.Description
End Sub

Public Sub printmultiline(X As String, rtf As RichTextBox, spaceneeded As Integer)
Dim I As Integer

With rtf
I = 1
While I <= Len(X)
    If Mid(X, I, 2) = vbCrLf Then
        .Text = .Text & vbCrLf & Space(spaceneeded)
        I = I + 2
    Else
        .Text = .Text & Mid(X, I, 1)
        I = I + 1
    End If

Wend
.Text = .Text & vbCrLf
End With
End Sub

Public Sub find_all_information_of_project(cde As Long, rtf As RichTextBox, date_beg As Date, date_end As Date, date_provided As Boolean)

On Error GoTo cancel
Dim I, j, k As Integer
Dim flg As Boolean
Dim X As New Connection
Dim Y As New Recordset
Dim y1 As New Recordset
Dim y2 As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

With rtf
 .SelFontName = "courier new"
 .SelFontSize = 8
 .SelBold = True
 .SelIndent = 500
 .SelHangingIndent = -250
 .SelRightIndent = 100
 .RightMargin = 20000

.Text = Space(10) & "PROJECT INFORMATION FOR PROJECT WITH ID " & Str(cde) & vbCrLf
 Call formattextinrtf(rtf, findvalidstring(.Text), "courier new", 9)
.Text = .Text & Space(10) & "****************************************" & vbCrLf
Set Y = X.Execute("select  projname,completed,deleted from projects where projid=" & cde & "")
Y.MoveFirst
.Text = .Text & Space(10) & "Name Of The Project:" & Trim(Y("projname")) & "." & vbCrLf
.Text = .Text & Space(10) & "Project's Status:"
.Text = .Text & IIf(Y("completed") = "F", "Incompleted", "Completed") & "." & vbCrLf
.Text = .Text & Space(10) & "Project's Scope:" & IIf(Y("deleted") = "T", "Deleted", "Active Project") & "."
Y.Close
.Text = .Text & vbCrLf & vbCrLf & Space(10) & "PERSONS WORKED/WORKING ON THE PROJECT AS PROJECT-MANAGER" & vbCrLf
.Text = .Text & Space(10) & "********************************************************" & vbCrLf & vbCrLf
Set Y = X.Execute("select * from projectsassignedto where projid=" & cde & "")
Y.MoveFirst
I = 1
While Not Y.EOF
         .Text = .Text & vbCrLf & Str(I) & "." & vbCrLf
         Call printperson(Val(Y("personid")), rtf)
         .Text = .Text & Space(10) & "Project Assigned Date:" & Format$(Y("assigneddate"), "dd-mmm-yyyy") & "." & vbCrLf
         .Text = .Text & Space(10) & "PERSON'S STATUS:"
         Select Case Y("status")
            Case "I":
                    .Text = .Text & "Project is not Completed."
            Case "C":
                    .Text = .Text & "Project is already Completed."
            Case "T":
                    .Text = .Text & "Person is Eliminated from the project."
         End Select
         Y.MoveNext
         I = I + 1
Wend
Y.Close

If Not date_provided Then
    .Text = .Text & vbCrLf & vbCrLf & vbCrLf & Space(10) & "SUBTASK DETAILS OF THE PROJECT" & vbCrLf
    .Text = .Text & Space(10) & "******************************" & vbCrLf & vbCrLf
Else
    .Text = .Text & vbCrLf & vbCrLf & vbCrLf & Space(10) & "SUBTASK DETAILS OF THE PROJECT BETWEEN DATES" & vbCrLf & Space(18) & Format$(Str(date_beg), "dd-mmm-yyyy") _
         & " and " & Format$(Str(date_end), "dd-mmm-yyyy") & vbCrLf
    .Text = .Text & Space(10) & "********************************************" & vbCrLf
    .Text = .Text & Space(5) & "SUBTASK MANAGERS WORKED BETWEEN THESE DAYS ARE GIVEN BELOW" & vbCrLf
    .Text = .Text & Space(5) & "**********************************************************" & vbCrLf & vbCrLf & vbCrLf
End If

k = 1
While k <= 2
  If k = 1 Then
    .Text = .Text & vbCrLf & "INFORMATION ABOUT COMPLETED SUBTASKS WITH PERSONS WORKED" & vbCrLf
    .Text = .Text & "--------------------------------------------------------" & vbCrLf & vbCrLf
    Set Y = X.Execute("select taskid from projectinprogress where(projid=" & cde _
        & " and enddate is not null)")
  Else
     .Text = .Text & vbCrLf & vbCrLf & "INFORMATION ABOUT INCOMPLETED SUBTASKS WITH PERSONS WORKED/WORKING" & vbCrLf
     .Text = .Text & "------------------------------------------------------------------" & vbCrLf & vbCrLf
     Set Y = X.Execute("select taskid from projectinprogress where(projid=" & cde _
        & " and enddate is null)")
  End If

  If Y.RecordCount <= 0 Then
     If k = 1 Then
        .Text = .Text & "No subtask is completed for this Project."
     Else
        .Text = .Text & "All Subtasks are Completed for this Project,So no incompleted Tasks."
     End If
  Else
     Y.MoveFirst
     I = 1
     While Not Y.EOF
        .Text = .Text & vbCrLf & vbCrLf & Str(I) & "."
        Set y1 = X.Execute("select taskname from subtasks where(projid=" & cde & " and taskid=" & Y("taskid") & ")")
        .Text = .Text & "Taskname:" & Trim(y1("taskname")) & "." & vbCrLf & " -----------" & vbCrLf
        y1.Close
        Set y1 = X.Execute("select personid,assigneddate,status from subtasksassignedto where" _
              & "(projid=" & cde & " and taskid=" & Y("taskid") & ")")
        j = 1
        y1.MoveFirst
        flg = False
        While Not y1.EOF
           
          If db_type_oracle Then
                Set y2 = X.Execute("select * from register where(personid=" & y1("personid") _
                      & " and projid=" & cde & " and taskid=" & Val(Y("taskid")) & " and entrydate between '" _
                      & Format$(Str(date_beg), "dd-mmm-yyyy") & "' and '" & Format$(Str(date_end), "dd-mmm-yyyy") & "')")
          Else
                Set y2 = X.Execute("select * from register where(personid=" & y1("personid") _
                      & " and projid=" & cde & " and taskid=" & Val(Y("taskid")) & " and entrydate between cdate('" _
                      & Format$(Str(date_beg), "dd-mmm-yyyy") & "') and cdate('" & Format$(Str(date_end), "dd-mmm-yyyy") & "'))")
          End If
          
          
          If Not date_provided Or (date_provided And y2.RecordCount > 0) Then
              flg = True
              .Text = .Text & vbCrLf & vbCrLf & Space(5) & Str(j) & "." & vbCrLf
              Call printperson(Val(y1("personid")), rtf)
              .Text = .Text & vbCrLf & Space(5) & "Task assigned Date:" & Format$(CStr(y1("assigneddate")), "dd-mmm-yyyy") & "."
              .Text = .Text & vbCrLf & Space(5) & "Status:"
              Select Case y1("status")
                  Case "I":
                     .Text = .Text & "Task is not Completed."
                  Case "C":
                     .Text = .Text & "Task is already Completed."
                  Case "T":
                     .Text = .Text & "Person is Eliminated from the Task."
              End Select
              j = j + 1
           End If
           y1.MoveNext
        Wend
        If flg = False And date_provided Then
            .Text = .Text & vbCrLf & "No person worked for this Task in the date interval Specified." & vbCrLf
        Else
            .Text = .Text & vbCrLf
        End If
        I = I + 1
        Y.MoveNext
     Wend
  End If
  k = k + 1
Wend
End With

Exit Sub
cancel:

 MsgBox Err.Description
End Sub

Public Sub printperson(id As Long, rtf As RichTextBox)
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

Set Y = X.Execute("select name from person where id=" & id & "")

If Y.RecordCount <= 0 Then

    With rtf
        .Text = .Text & Space(10) & "Person with id " & Str(id) & " not exsists." & vbCrLf
     End With
Else
    With rtf
        .Text = .Text & "          Personnel Id:" & Str(id) & vbCrLf
        .Text = .Text & "          Name:" & Trim(Y("name")) & vbCrLf
   End With
End If

Exit Sub
cancel:
    MsgBox Err.Description
End Sub




