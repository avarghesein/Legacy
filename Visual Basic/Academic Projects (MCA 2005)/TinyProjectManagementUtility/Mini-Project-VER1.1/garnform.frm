VERSION 5.00
Begin VB.Form garnform 
   AutoRedraw      =   -1  'True
   Caption         =   "GARN TYPE"
   ClientHeight    =   5535
   ClientLeft      =   1230
   ClientTop       =   1980
   ClientWidth     =   9480
   BeginProperty Font 
      Name            =   "Book Antiqua"
      Size            =   9
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "garnform.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   369
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   632
   Begin VB.PictureBox garnpic 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00C0FFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5295
      Left            =   0
      ScaleHeight     =   349
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   613
      TabIndex        =   0
      Top             =   120
      Width           =   9255
   End
End
Attribute VB_Name = "garnform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim g_type As Integer


Dim garn_g As garngeneral
Dim garn_e() As garnelement

Dim path As struct_path


Private Sub Form_Load()
On Error GoTo cancel

Dim X As New Connection
Dim Y As New Recordset
Dim y1 As New Recordset

Dim ang As Double
Dim ang_inc As Double

Set X = dn.cn
If X.State = adStateClosed Then X.Open

If mgarn.garn_type = "PATH" Or mgarn.garn_type = "CPATH" Then
    
    If mgarn.garn_type = "PATH" Then
        g_type = 3
    Else
        g_type = 4
    End If
    
    Set Y = X.Execute("select taskname as tnam,taskid as tid,taskduration as tdur from subtasks where projid=" & glob_proj.pid & " order by taskearly")
    path.task_count = 0
    ang = 0
    If Not Y.BOF And Not Y.EOF Then
        Y.MoveFirst
        ang_inc = 360# / Y.RecordCount
        ReDim path.g_path(Y.RecordCount + 1) As graphical_path
    End If
    
    While Not Y.EOF
        path.g_path(path.task_count).taskname = Trim(Trim(Y("tnam")) & "(" & Trim(Str(Y("tdur"))) & ")")
        path.g_path(path.task_count).taskid = Val(Y("tid"))
        path.g_path(path.task_count).angle = ang
        
        Set y1 = X.Execute("select distinct(taskrelated) from predecessortasks where(projid=" & glob_proj.pid & " and taskid=" & Val(Y("tid")) & " and taskrelated is not null)")
        If y1.BOF And y1.EOF Then
            path.g_path(path.task_count).initial = True
        Else
            path.g_path(path.task_count).initial = False
        End If
        
        Set y1 = X.Execute("select distinct(taskrelated) from successortasks where(projid=" & glob_proj.pid & " and taskid=" & Val(Y("tid")) & " and taskrelated is not null)")
        If y1.BOF And y1.EOF Then
            path.g_path(path.task_count).final = True
        Else
            path.g_path(path.task_count).final = False
        End If
        
        ang = ang + ang_inc
        path.task_count = path.task_count + 1
        Y.MoveNext
    Wend
End If

If mgarn.garn_type = "EARLY" Then
    g_type = 0
    Set Y = X.Execute("select taskname as tnam,taskearly as early,taskduration as tdur" _
        & " from subtasks where projid=" & glob_proj.pid & " order by taskearly")
    Call earlyorlate_garnformat(Y, "tnam", "early", "tdur", garn_g, garn_e)
Else
    If mgarn.garn_type = "LATE" Then
        g_type = 1
        Set Y = X.Execute("select taskname as tnam,tasklate as late,taskduration as tdur" _
        & " from subtasks where projid=" & glob_proj.pid & " order by taskearly")
        Call earlyorlate_garnformat(Y, "tnam", "late", "tdur", garn_g, garn_e)
    End If
End If


If mgarn.garn_type = "REAL" Then
    g_type = 2
    Set Y = X.Execute("select taskname as t,startdate as s,enddate as e from subtasks   sub, " _
            & "projectinprogress  pro where (sub.projid=" & glob_proj.pid & " and " _
            & "pro.projid=sub.projid and sub.taskid=pro.taskid and startdate is not null and enddate is not null) order by startdate")
            
    If Y.RecordCount <= 0 Then
        garn_g.taskcount = 0
    Else
        Call real_garnformat(Y, "t", "s", "e", garn_g, garn_e)
    End If
End If

Call Form_Resize

Exit Sub

cancel:
    MsgBox Err.Description
End Sub


Private Sub Form_Resize()
garnpic.Cls
garnpic.Left = 0
garnpic.Top = 0
garnpic.Height = Me.ScaleHeight
garnpic.Width = Me.ScaleWidth

If g_type <= 2 Then
    If garn_g.taskcount > 0 Then
        Call draw_garn_chart(garnpic, garn_g, garn_e)
    Else
        Me.garnpic.CurrentX = 10
        Me.garnpic.CurrentY = (Me.garnpic.Height) / 2
        Me.garnpic.Print "NO TASKS COMPLETED FOR THIS PROJECT"
    End If
Else
    If g_type = 3 Then
        Call draw_path(garnpic, path, False)
    Else
        Call draw_path(garnpic, path, True)
    End If
End If

End Sub

