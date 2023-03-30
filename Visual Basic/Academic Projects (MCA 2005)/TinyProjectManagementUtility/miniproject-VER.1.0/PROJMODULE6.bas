Attribute VB_Name = "projmodule6"


Option Explicit

'-------------------Needed Critical Array-----------------'
Public critical_rows As Long

Type critical
    cols As Long
    arrays() As String
End Type

Public critical_paths() As critical

'--------------------------End Need-----------------------------'


Type node
    cols As Long
    arrays() As Integer
End Type

Dim rows As Long
Dim X() As node

Dim con As New Connection
Dim Y As New Recordset


Private Sub findallpaths(pid As Long)
On Error GoTo cancel
Dim I As Integer
Dim j As Integer

If con.State = 0 Then con.Open

Set Y = con.Execute("select distinct(taskid) as taskid from predecessortasks where(projid=" & pid & " and taskrelated is null)")

rows = -1

If Not Y.EOF And Not Y.BOF Then
    Y.MoveFirst
    ReDim Preserve X(Y.RecordCount) As node
    While Not Y.EOF
        rows = rows + 1
        X(rows).cols = 0
        ReDim Preserve X(rows).arrays(1) As Integer
        X(rows).arrays(X(rows).cols) = Val(Y("taskid"))
        Y.MoveNext
    Wend
End If
Y.Close

I = 0
While Not all_end()

 If X(I).arrays(X(I).cols) <> -1 Then
    Set Y = con.Execute("select distinct(taskrelated) as related from successortasks where(projid=" & pid & " and " & _
            " taskid=" & X(I).arrays(X(I).cols) & " and taskrelated is not null)")
    If Not Y.EOF And Not Y.BOF Then
        Y.MoveFirst
        X(I).cols = X(I).cols + 1
        ReDim Preserve X(I).arrays(X(I).cols + 1) As Integer
        X(I).arrays(X(I).cols) = Val(Y("related"))
        Y.MoveNext
        While Not Y.EOF
            rows = rows + 1
            ReDim Preserve X(rows + 1) As node
            ReDim Preserve X(rows).arrays(X(I).cols + 1) As Integer
            j = 0
            While j <= X(I).cols - 1
                X(rows).arrays(j) = X(I).arrays(j)
                j = j + 1
            Wend
            X(rows).cols = j
            X(rows).arrays(X(rows).cols) = Val(Y("related"))
            Y.MoveNext
        Wend
        Y.Close
    Else
        X(I).cols = X(I).cols + 1
        ReDim Preserve X(I).arrays(X(I).cols + 1) As Integer
        X(I).arrays(X(I).cols) = -1
    End If
 End If
 I = I + 1
 If I > rows Then I = 0
Wend


Exit Sub
cancel:
    MsgBox Err.Description

End Sub

Private Function all_end() As Boolean

Dim I As Integer

For I = 0 To rows Step 1
    If (X(I).arrays(X(I).cols)) <> -1 Then
        all_end = False
        Exit Function
    End If
Next I
all_end = True

End Function

Public Sub find_critical_paths(pid As Long)
On Error GoTo cancel
Dim I As Integer
Dim j As Integer
Dim tmp_dur As Long

Set con = dn.cn

Call findallpaths(pid)
Set Y = con.Execute("select projduration as dur,projname as nam from projects where projid=" & pid & "")
Y.MoveFirst
glob_proj.pdur = Val(Y("dur"))
glob_proj.pnam = Trim(Y("nam"))
I = 0
critical_rows = -1
While I <= rows
    j = 0
    tmp_dur = 0
    While j <= X(I).cols - 1
        Set Y = con.Execute("select taskduration as dur from subtasks where(projid=" & pid & " and taskid=" & X(I).arrays(j) & ")")
        Y.MoveFirst
        tmp_dur = tmp_dur + Val(Y("dur"))
        j = j + 1
        Y.Close
    Wend

    If tmp_dur = glob_proj.pdur Then
        critical_rows = critical_rows + 1
        ReDim Preserve critical_paths(critical_rows + 1) As critical
        critical_paths(critical_rows).cols = X(I).cols - 1
        ReDim critical_paths(critical_rows).arrays(X(I).cols) As String
        j = 0
        While j <= X(I).cols - 1
            Set Y = con.Execute("select taskname from subtasks where(projid=" & pid & " and taskid=" & X(I).arrays(j) & ")")
            Y.MoveFirst
            critical_paths(critical_rows).arrays(j) = Trim(Y("taskname"))
            j = j + 1
            Y.Close
        Wend
    End If
I = I + 1
Wend

Exit Sub
cancel:
    MsgBox Err.Description
End Sub








