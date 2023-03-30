VERSION 5.00
Begin VB.Form reshedulesub 
   Caption         =   "SELECTING PREDECESSORS & SUCCESSORS FOR NEW TASK"
   ClientHeight    =   6240
   ClientLeft      =   1410
   ClientTop       =   1755
   ClientWidth     =   9315
   Icon            =   "reshedulesub.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   6240
   ScaleWidth      =   9315
   Begin VB.CommandButton creload 
      Caption         =   "RESET"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   7080
      TabIndex        =   11
      Top             =   5640
      Width           =   2055
   End
   Begin VB.CommandButton canceltsk 
      Caption         =   "RESCHEDULE CANCEL"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   6
      Top             =   5640
      Width           =   2055
   End
   Begin VB.CommandButton savetsk 
      Caption         =   "RESCHEDULE NOW"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   5
      Top             =   5640
      Width           =   2055
   End
   Begin VB.Frame fsubtsks 
      Caption         =   "SELECT SUCCESSORS OF THE TASK"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3855
      Index           =   1
      Left            =   5160
      TabIndex        =   2
      Top             =   1560
      Width           =   3975
      Begin VB.CommandButton csuccok 
         Caption         =   "OK"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   10
         Top             =   3360
         Width           =   1455
      End
      Begin VB.CommandButton csuccnotok 
         Caption         =   "CANCEL"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2400
         TabIndex        =   9
         Top             =   3360
         Width           =   1455
      End
      Begin VB.ListBox subtsks 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2910
         Index           =   1
         ItemData        =   "reshedulesub.frx":030A
         Left            =   120
         List            =   "reshedulesub.frx":030C
         Sorted          =   -1  'True
         Style           =   1  'Checkbox
         TabIndex        =   3
         Top             =   240
         Width           =   3735
      End
   End
   Begin VB.Frame fsubtsks 
      Caption         =   "SELECT PREDECESSORS OF THE TASK"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3855
      Index           =   0
      Left            =   240
      TabIndex        =   0
      Top             =   1560
      Width           =   3975
      Begin VB.CommandButton cpredok 
         Caption         =   "OK"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   8
         Top             =   3360
         Width           =   1575
      End
      Begin VB.CommandButton cprednotok 
         Caption         =   "CANCEL"
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2280
         TabIndex        =   7
         Top             =   3360
         Width           =   1575
      End
      Begin VB.ListBox subtsks 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2910
         Index           =   0
         ItemData        =   "reshedulesub.frx":030E
         Left            =   120
         List            =   "reshedulesub.frx":0310
         Sorted          =   -1  'True
         Style           =   1  'Checkbox
         TabIndex        =   1
         Top             =   240
         Width           =   3735
      End
   End
   Begin VB.Label ltask 
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   2520
      TabIndex        =   4
      Top             =   120
      Width           =   4815
   End
   Begin VB.Menu exitresub 
      Caption         =   "EXIT!"
   End
End
Attribute VB_Name = "reshedulesub"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit


Private Sub canceltsk_Click()
    Unload Me
End Sub


Private Sub cprednotok_Click()
    Call Form_Load
End Sub

Private Sub cpredok_Click()
    fsubtsks(0).Enabled = False
    cpredok.Enabled = False
    cprednotok.Enabled = False
    fsubtsks(1).Enabled = True
    csuccok.Enabled = True
    csuccnotok.Enabled = True
    Call check3combolist(subtsks(0), subtsks(1), introduction.projnamecombo)
End Sub

Private Sub creload_Click()
    Call Form_Load
End Sub

Private Sub csuccnotok_Click()
Dim I As Integer

    For I = 0 To subtsks(1).ListCount - 1
        If subtsks(1).Selected(I) = True Then
            subtsks(1).Selected(I) = False
        End If
    Next I
End Sub

Private Sub csuccok_Click()
    fsubtsks(1).Enabled = False
    csuccok.Enabled = False
    csuccnotok.Enabled = False
    savetsk.Enabled = True
End Sub

Private Sub exitresub_Click()
    Unload Me
End Sub

Private Sub Form_Load()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

fsubtsks(1).Enabled = False
csuccok.Enabled = False
csuccnotok.Enabled = False
fsubtsks(0).Enabled = True
cpredok.Enabled = True
cprednotok.Enabled = True
savetsk.Enabled = False

ltask.Caption = "Project Id:" & Str(glob_task.pid) & vbCrLf & _
        "New Task Name:" & glob_task.tnam & vbCrLf & "New Taskid:" & glob_task.tid & vbCrLf & _
        "Task Manager-id:" & Str(glob_task.tmanager) & vbCrLf & "Task Manager Name:" & resheduleform.sel_nam



Set Y = X.Execute("select taskname,taskid from tmp_subtasks where(projid=" & glob_task.pid & " and taskid not in" & _
      "(select distinct(taskid) from tmp_projectinprogress where(projid=" & glob_task.pid & " and startdate is not null)))")

Call addtocombolist(introduction.projnamecombo, Y, "taskname", "taskid")
Call addtocombolist(subtsks(1), Y, "taskname", "taskid")

Set Y = X.Execute("select taskname,taskid from tmp_subtasks where projid=" & glob_task.pid & "")

Call addtocombolist(subtsks(0), Y, "taskname", "taskid")

Y.Close

Exit Sub
cancel:
    MsgBox Err.Description
End Sub

Private Sub Form_Unload(cancel As Integer)
    ltask.Caption = "NONE"
    
    glob_proj.pstart = DateValue(Format$("01/01/01", "mm/dd/yyyy"))
    glob_proj.pid = 0
    glob_task.pid = 0
    glob_task.tdesc = ""
    glob_task.tid = 0
    glob_task.tmanager = 0
    glob_task.tnam = ""
    glob_task.tdur = 0
    
    resheduleform.reloadtables
    resheduleform.Show
End Sub

Private Sub savetsk_Click()
Dim X As New Connection
Dim Y As New Recordset
Dim sel_flg As Boolean
Dim I As Integer


If MsgBox("ARE YOU SURE TO ADD THIS NEW TASK TO THE PROJECT", vbYesNo, "CONFIRM") = vbNo Then
    Exit Sub
End If

Set X = dn.cn
If X.State = 0 Then X.Open

X.BeginTrans
X.Execute "insert into tmp_subtasks(taskid,projid,taskname,taskdesc,taskduration,taskearly,tasklate,taskmanager) values " _
        & "(" & glob_task.tid & "," & glob_task.pid & ",'" & glob_task.tnam & "','" & glob_task.tdesc & "'," & glob_task.tdur & ",null,null," & glob_task.tmanager & ")"

X.Execute "insert into tmp_projectinprogress(taskid,projid,startdate,enddate)" & _
          " values(" & glob_task.tid & "," & glob_task.pid & ",null,null)"

sel_flg = False
For I = 0 To subtsks(0).ListCount - 1 Step 1
    If subtsks(0).Selected(I) = True Then
        sel_flg = True
        Set Y = X.Execute("select distinct(taskid) as related from tmp_successortasks where(projid=" & glob_task.pid & " and " & _
              " taskid=" & subtsks(0).ItemData(I) & " and taskrelated is null)")
        
        If Y.RecordCount > 0 Then
            X.Execute "update tmp_successortasks set taskrelated=" & glob_task.tid & _
              " where(projid=" & glob_task.pid & " and taskid=" & subtsks(0).ItemData(I) & ")"
        Else
            X.Execute "insert into tmp_successortasks(taskid,projid,taskrelated) values" & _
               "(" & subtsks(0).ItemData(I) & "," & glob_task.pid & "," & glob_task.tid & ")"
        End If
        
        
        X.Execute "insert into tmp_predecessortasks(taskid,projid,taskrelated) values(" & _
         glob_task.tid & "," & glob_task.pid & "," & subtsks(0).ItemData(I) & ")"
    End If
Next I


If Not sel_flg Then
    X.Execute "insert into tmp_predecessortasks(taskid,projid,taskrelated) values(" & _
         glob_task.tid & "," & glob_task.pid & ",null)"
End If

sel_flg = False
For I = 0 To subtsks(1).ListCount - 1 Step 1
    If subtsks(1).Selected(I) = True Then
        sel_flg = True
        Set Y = X.Execute("select distinct(taskid) as related from tmp_predecessortasks where(projid=" & glob_task.pid & " and " & _
              " taskid=" & subtsks(1).ItemData(I) & " and taskrelated is null)")
        
        If Y.RecordCount > 0 Then
            X.Execute "update tmp_predecessortasks set taskrelated=" & glob_task.tid & _
              " where(projid=" & glob_task.pid & " and taskid=" & subtsks(1).ItemData(I) & ")"
        Else
            X.Execute "insert into tmp_predecessortasks(taskid,taskrelated,projid) values" & _
              "(" & subtsks(1).ItemData(I) & "," & glob_task.tid & "," & glob_task.pid & ")"
        End If

         X.Execute "insert into tmp_successortasks(taskid,projid,taskrelated) values(" & _
         glob_task.tid & "," & glob_task.pid & "," & subtsks(1).ItemData(I) & ")"
    End If
Next I

If Not sel_flg Then
    X.Execute "insert into tmp_successortasks(taskid,projid,taskrelated) values(" & _
         glob_task.tid & "," & glob_task.pid & ",null)"
End If


Call re_earlylatestarts_settings(glob_task.pid)
Call save_resheduled(glob_task.pid)
Unload Me

Exit Sub
cancel:
    MsgBox Err.Description
    Unload Me
End Sub

