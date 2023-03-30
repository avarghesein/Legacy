VERSION 5.00
Begin VB.Form tasksform 
   Caption         =   "TASK SCHEDULER"
   ClientHeight    =   5445
   ClientLeft      =   1830
   ClientTop       =   2145
   ClientWidth     =   8790
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "tasksform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   363
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   586
   Begin VB.CommandButton cselectid 
      Caption         =   "SELECT ID"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5948
      TabIndex        =   4
      Top             =   2175
      Width           =   1095
   End
   Begin VB.Frame fsubtsks 
      Caption         =   "SELECT ITEMS FOR DELETE"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1815
      Left            =   120
      TabIndex        =   14
      Top             =   3495
      Width           =   3735
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
         Height          =   1485
         ItemData        =   "tasksform.frx":030A
         Left            =   120
         List            =   "tasksform.frx":030C
         Sorted          =   -1  'True
         Style           =   1  'Checkbox
         TabIndex        =   7
         Top             =   240
         Width           =   3495
      End
   End
   Begin VB.Frame fsubtsks1 
      Caption         =   "SELECT TASK TO SET PREDECESSORS"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4215
      Left            =   4800
      TabIndex        =   13
      Top             =   240
      Visible         =   0   'False
      Width           =   3855
      Begin VB.ListBox subtsks1 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3885
         ItemData        =   "tasksform.frx":030E
         Left            =   120
         List            =   "tasksform.frx":0310
         Sorted          =   -1  'True
         TabIndex        =   8
         Top             =   240
         Width           =   3615
      End
   End
   Begin VB.TextBox tskdesc 
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   3788
      MaxLength       =   195
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   495
      Width           =   3855
   End
   Begin VB.CommandButton canceltsk 
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
      Height          =   495
      Left            =   7680
      TabIndex        =   6
      Top             =   4695
      Width           =   975
   End
   Begin VB.CommandButton savetsk 
      Caption         =   "SAVE "
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   6480
      TabIndex        =   5
      Top             =   4680
      Width           =   975
   End
   Begin VB.TextBox tskname 
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   3788
      MaxLength       =   30
      TabIndex        =   0
      Top             =   135
      Width           =   3855
   End
   Begin VB.TextBox tskman 
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   3788
      Locked          =   -1  'True
      MaxLength       =   7
      TabIndex        =   3
      Top             =   2175
      Width           =   2055
   End
   Begin VB.TextBox tskdur 
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   3788
      MaxLength       =   20
      TabIndex        =   2
      Top             =   1815
      Width           =   2055
   End
   Begin VB.Label lman 
      Alignment       =   1  'Right Justify
      Caption         =   " "
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   428
      TabIndex        =   15
      Top             =   2775
      Width           =   3375
   End
   Begin VB.Label ltdesc 
      Alignment       =   1  'Right Justify
      Caption         =   "TASK DESCRIPTION"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1628
      TabIndex        =   12
      Top             =   1095
      Width           =   2055
   End
   Begin VB.Label ltman 
      Alignment       =   1  'Right Justify
      Caption         =   "TASK MANAGER"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1628
      TabIndex        =   11
      Top             =   2295
      Width           =   2055
   End
   Begin VB.Label ltduration 
      Alignment       =   1  'Right Justify
      Caption         =   "DURATION IN DAYS"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1628
      TabIndex        =   10
      Top             =   1935
      Width           =   2055
   End
   Begin VB.Label ltname 
      Alignment       =   1  'Right Justify
      Caption         =   "TASK NAME"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1628
      TabIndex        =   9
      Top             =   255
      Width           =   2055
   End
   Begin VB.Menu exits 
      Caption         =   "EXIT!"
   End
   Begin VB.Menu subtsk 
      Caption         =   "SUBTASK "
      Begin VB.Menu addtask 
         Caption         =   "ADD SUBTASK "
         Shortcut        =   ^A
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu remove 
         Caption         =   "REMOVE SUBTASK"
      End
   End
   Begin VB.Menu tools 
      Caption         =   "TOOLS"
      Begin VB.Menu setprds 
         Caption         =   "SET PREDECESSORS"
      End
   End
End
Attribute VB_Name = "tasksform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public owner_admin As Boolean
Public admin_change_all As Boolean

Dim flg_id As Boolean
Dim predflg As Boolean
Dim predafterflg As Boolean
Dim tot_tasks As Integer


Private Sub addtask_Click()
    Call canceltsk_Click
    Call enablesubtasks(True)
    tskname.SetFocus
End Sub

Private Sub canceltsk_Click()
Dim I As Integer

If predflg = False Then
    tskname = ""
    tskdur = ""
    tskman = ""
    tskdesc = ""
    lman.Caption = ""
    Call enablesubtasks(False)
Else
    For I = 0 To subtsks.ListCount - 1
            subtsks.Selected(I) = False
    Next I
    
    If predafterflg = True Then
        For I = 0 To subtsks1.ListCount - 1
            subtsks1.Selected(I) = False
        Next I
    End If

End If
canceltsk.Enabled = False
savetsk.Enabled = False
End Sub

Private Sub cselectid_Click()
    flg_id = True
    tskman = ""
    Me.Hide
    personform.owner = "TASKFORM"
    personform.person_chois = "SELECT"
    personform.Show
End Sub

Private Sub exits_Click()
    Unload Me
End Sub

Private Sub Form_GotFocus()
 If flg_id = False And tskname.Visible Then
        tskname.SetFocus
 Else
       flg_id = False
 End If
End Sub

Private Sub Form_Load()
Dim I As Integer
Dim started_tasks As String
Dim flg As Boolean
Dim Y As New Recordset

If dn.cn.State = adStateClosed Then dn.cn.Open
dn.cn.BeginTrans

If owner_admin = False Then
        flg_id = False
        predflg = False
        savetsk.Enabled = False
        canceltsk.Enabled = False
        remove.Enabled = False
        Call enablesubtasks(False)
        tot_tasks = 0
        tools.Enabled = False
        
        glob_proj.pid = getmaxid("projid", "projects", "0", False)
        Me.Caption = "YOUR PROJECT ID IS " & Str(glob_proj.pid)
             
        If Not addtoprojects(glob_proj.pid, glob_proj.pnam, glob_proj.pdesc, glob_proj.pstart, glob_proj.pmanager, glob_proj.pwd) Then
            MsgBox "PROJECT ENTRY FAILED", vbCritical, "PROJECT-ENTRY"
            Call Form_QueryUnload(0, 1)
        End If
Else
    glob_task.pid = glob_proj.pid
    Set Y = dn.cn.Execute("select projstartdate as strt from projects where projid=" & glob_proj.pid & "")
    Y.MoveFirst
    glob_proj.pstart = DateValue(Y("strt"))
    If admin_change_all Then
            dn.cn.Execute "delete from predecessortasks where projid=" & glob_proj.pid & ""
            dn.cn.Execute "delete from successortasks where projid=" & glob_proj.pid & ""
            dn.cn.Execute "delete from subtasksassignedto where (projid=" & glob_proj.pid & " and status='I')"
            dn.cn.Execute "update subtasks set taskearly=null,tasklate=null where projid=" & glob_proj.pid & ""
            Set Y = dn.cn.Execute("select taskname as nam,taskid as tid from subtasks where projid=" & glob_proj.pid & "")
            Call addtocombolist(subtsks, Y, "nam", "tid")
                
            flg_id = False
            predflg = False
            savetsk.Enabled = False
            canceltsk.Enabled = False
            remove.Enabled = True
            Call enablesubtasks(False)
            tot_tasks = subtsks.ListCount
            tools.Enabled = True
    Else
            started_tasks = "select distinct(taskid) from projectinprogress where(projid=" & glob_proj.pid & " and startdate is not null)"
            Set Y = dn.cn.Execute("select taskname as nam,taskid as tid from subtasks where(projid=" & glob_proj.pid & " and taskid in(" & started_tasks & "))")
            Call addtocombolist(subtsks, Y, "nam", "tid")
            Set Y = dn.cn.Execute("select taskname as nam,taskid as tid from subtasks where(projid=" & glob_proj.pid & " and taskid not in(" & started_tasks & "))")
            Call addtocombolist(subtsks1, Y, "nam", "tid")
            dn.cn.Execute "delete from successortasks where(projid=" & glob_proj.pid & " and taskrelated not in(" & started_tasks & "))"
            dn.cn.Execute "delete from predecessortasks where(projid=" & glob_proj.pid & " and taskid not in(" & started_tasks & "))"
            dn.cn.Execute "delete from successortasks where(projid=" & glob_proj.pid & " and taskid not in(" & started_tasks & "))"
            dn.cn.Execute "delete from subtasksassignedto where (projid=" & glob_proj.pid & " and status='I')"
            dn.cn.Execute "update subtasks set taskearly=null,tasklate=null where projid=" & glob_proj.pid & ""
            predflg = True
            Call setprds_Click
            If subtsks.ListCount <= 0 Then
                Call copycombolist_1to2(subtsks1, subtsks, True)
                predafterflg = False
            Else
                predafterflg = True
                fsubtsks.Move fsubtsks1.Left, fsubtsks1.Top
                fsubtsks1.Move 15, fsubtsks.Top + 30
                fsubtsks.Caption = "SELECT PREDECESSORS FROM THIS LIST"
                fsubtsks1.Visible = True
            End If
    End If
End If

End Sub

Private Sub Form_QueryUnload(cancel As Integer, UnloadMode As Integer)

Dim exitsure As Boolean

exitsure = False

If predflg = False Then
    If tot_tasks <= 0 Then
         If MsgBox("NO SUBTASKS FOR PROJECT" & vbCrLf & IIf(Not owner_admin, "PROJECT GOING TO BE DELETED", "RESCHEDULING GOING TO BE ABORTED") & vbCrLf _
           & "ARE YOU SURE?", vbOKCancel, IIf(Not owner_admin, "PROJECT GOING TO BE DELETED!!!", "RESCHEDULING GOING TO BE ABORTED!!!")) = vbCancel Then
              cancel = 1
         Else
              exitsure = True
              cancel = 0
         End If
              
    Else
         If MsgBox("TASK'S RELATION WITH RESPECT TO PROJECT IS NOT DEFINED" & vbCrLf & IIf(Not owner_admin, "PROJECT GOING TO BE DELETED", "RESCHEDULING GOING TO BE ABORTED") & vbCrLf _
           & "ARE YOU SURE?", vbOKCancel, IIf(Not owner_admin, "PROJECT GOING TO BE DELETED!!!", "RESCHEDULING GOING TO BE ABORTED!!!")) = vbCancel Then
              cancel = 1
         Else
              exitsure = True
              cancel = 0
         End If
   End If

Else
   If predafterflg = False Or subtsks1.ListCount > 0 Then
       If MsgBox("SOME TASKS NOT DEFINED AS INITIAL TASKS OR PREDECESSORS NOT SET FOR ALL TASKS " & vbCrLf & IIf(Not owner_admin, "PROJECT GOING TO BE DELETED", "RESCHEDULING GOING TO BE ABORTED") & vbCrLf _
           & "ARE YOU SURE?", vbOKCancel, IIf(Not owner_admin, "PROJECT GOING TO BE DELETED!!!", "RESCHEDULING GOING TO BE ABORTED!!!")) = vbCancel Then
              cancel = 1
         Else
              exitsure = True
              cancel = 0
         End If
    Else
        Call nosucc_earlylatestarts_settings(glob_proj.pid)
        
        If Not owner_admin Then
            dn.cn.CommitTrans
            newproject.Show
            newproject.txtname.SetFocus
        Else
            If MsgBox("SAVE RESCHEDULED INFORMATION", vbYesNo, "SAVE CHANGES?,CONFIRM!!!") = vbYes Then
                If Not admin_change_all Then
                    dn.cn.Execute "delete from subtasksassignedto where(projid=" & glob_proj.pid & " and taskid in" & _
                    "(select distinct(taskid) from projectinprogress where(projid=" & glob_proj.pid & " and enddate is not null))" & _
                    " and status='I')"
                End If
                dn.cn.CommitTrans
            Else
                dn.cn.RollbackTrans
            End If
            adminform.Show
        End If
        
        Exit Sub
    End If

End If

If exitsure = True Then
    dn.cn.RollbackTrans
    
    If Not owner_admin Then
            newproject.Show
            newproject.txtname.SetFocus
    Else
            adminform.Show
    End If
        
End If


Exit Sub

cancel:
     MsgBox Err.Description
    
    dn.cn.RollbackTrans
    
    If Not owner_admin Then
            newproject.Show
            newproject.txtname.SetFocus
    Else
            adminform.Show
    End If
        
     
End Sub


Private Sub enablesubtasks(stat As Boolean)

If stat = True Then
    addtask.Enabled = False
Else
    addtask.Enabled = True
 
End If

tskname.Enabled = stat
tskdur.Enabled = stat
tskman.Enabled = stat
tskdesc.Enabled = stat
End Sub



Private Sub remove_Click()
Dim I, tmp As Integer
Dim flg As Boolean

If subtsks.ListCount <= 0 Then
   tmp = MsgBox("NO TASKS EXSISTS FOR YOUR PROJECT", vbOKOnly, "NO TASKS!!!")
   Exit Sub
End If


flg = False
I = 0
While I < subtsks.ListCount
   If subtsks.Selected(I) Then
     tmp = deletefromsubtasks(glob_proj.pid, subtsks.List(I), subtsks.ItemData(I))
     subtsks.RemoveItem (I)
     tot_tasks = tot_tasks - 1
     flg = True
   Else
      I = I + 1
   End If
Wend

If tot_tasks <= 0 Then
   tools.Enabled = False
   remove.Enabled = False
End If

If flg = False Then
  tmp = MsgBox("NO SELECTED TASKS", vbOKOnly, "SELECT A  TASK!!!")
End If

End Sub

Private Sub savetsk_Click()
Dim gotonext As Boolean
Dim I As Integer

If predflg = False Then
  If (Trim(tskname) <> "" And Not insubtasks(glob_proj.pid, _
      tskname, "subtasks")) And Val(tskdur) > 0 And Val(tskman) <> 0 Then
            glob_task.tid = getmaxid("taskid", "subtasks", glob_proj.pid, True)
            glob_task.pid = glob_proj.pid
            glob_task.tnam = tskname
            glob_task.tdesc = tskdesc
            glob_task.tdur = Val(tskdur)
            glob_task.tmanager = Val(tskman)
            If addtosubtasks(glob_task.tid, glob_task.pid, glob_task.tnam, glob_task.tdesc, _
              glob_task.tdur, glob_task.tmanager) = False Then
                MsgBox "SAVING FAILED", vbCritical, "ERROR TASK NOT SAVED"
              
            Else
                tot_tasks = tot_tasks + 1
                tools.Enabled = True
                remove.Enabled = True
                subtsks.AddItem (glob_task.tnam)
                subtsks.ItemData(subtsks.NewIndex) = glob_task.tid
                canceltsk_Click

            End If
            Exit Sub
    
    Else
        MsgBox "ERROR IN ENTERED INFORMATION(CHECK ALL DETAILS ENTERED/THERE MAY EXSIST A TASKNAME SAME AS YOU ENTERED FOR THIS PROJECT", vbOKOnly, "ERROR"
        Exit Sub
    End If
Else
    If predafterflg = False Then
        gotonext = False
        I = 0
        While (I <= subtsks.ListCount - 1)
            If subtsks.Selected(I) = True Then
                gotonext = True
                Call add_to_predsucc(glob_task.pid, _
                subtsks.ItemData(I), 0, True, "predecessortasks")
                I = I + 1
             Else
                subtsks1.AddItem (subtsks.List(I))
                subtsks1.ItemData(subtsks1.NewIndex) = subtsks.ItemData(I)
                subtsks.RemoveItem (I)
             End If
        Wend
        If gotonext = False Then
            MsgBox "NO INITIAL TASKS SELECTED", vbOKOnly, "ERROR SELECTION IN INITIAL TASKS"
            Call copycombolist_1to2(subtsks1, subtsks, True)
            Exit Sub
        End If
        predafterflg = True
        fsubtsks.Move fsubtsks1.Left, fsubtsks1.Top
        fsubtsks1.Move 15, fsubtsks.Top + 30
        fsubtsks.Caption = "SELECT PREDECESSORS FROM THIS LIST"
        fsubtsks1.Visible = True
     Else
        If subtsks1.ListIndex = -1 Then
            MsgBox "SUBTASK NOT SELECTED", vbOKOnly, "SELECTION ERROR"
            canceltsk_Click
            Exit Sub
        End If
        gotonext = False
        For I = 0 To subtsks.ListCount - 1
            If subtsks.Selected(I) = True Then
                gotonext = True
                
                Call add_to_predsucc(glob_proj.pid, subtsks1.ItemData(subtsks1.ListIndex), _
                subtsks.ItemData(I), False, "predecessortasks")
                
                Call add_to_predsucc(glob_proj.pid, subtsks.ItemData(I), subtsks1.ItemData(subtsks1.ListIndex), _
                False, "successortasks")
                
            End If
        Next I
        If gotonext = False Then
            MsgBox "NOT SELECTED ANY PREDECESSOR TASKS FOR " & _
              subtsks1.Text, vbOKOnly, "ERROR SELECTION OF PREDECESSORS"
              
            Exit Sub
        End If
        subtsks.AddItem (subtsks1.List(subtsks1.ListIndex))
        subtsks.ItemData(subtsks.NewIndex) = subtsks1.ItemData(subtsks1.ListIndex)
        subtsks1.RemoveItem (subtsks1.ListIndex)
        
    End If
                          
        
        canceltsk_Click
        If subtsks1.ListCount <= 0 Then
            For I = 0 To Me.Count - 1
                    Me.Controls(I).Enabled = False
            Next I
            exits.Enabled = True
            If Not owner_admin Then
                Me.Caption = "PROJECT ENTRY SUCCESS/CHOOSE CLOSE"
            Else
                Me.Caption = "PROJECT REENTRY SUCCESS/CHOOSE CLOSE"
            End If
        End If
End If

End Sub

Private Sub setprds_Click()

If Not owner_admin Then
    If MsgBox("YOU ARE GOING TO SET PREDECESSOR RELATIONSHIPS BETWEEN" _
        & " SUBTASKS/ARE YOU ENTERED ALL SUBTASKS FOR THE PROJECT?" _
        , vbYesNo, "QUIT CURRENT SUBTASK ENTRY SECTION!!!") = vbNo Then Exit Sub

    Me.Caption = "SUBTASK SCHEDULER"
Else
    Me.Caption = "SUBTASK RESCHEDULER"
End If

cselectid.Visible = False
subtsk.Visible = False
tools.Visible = False
tskname.Visible = False
tskdesc.Visible = False
tskdur.Visible = False
tskman.Visible = False
ltduration.Visible = False
ltname.Visible = False
ltdesc.Visible = False
ltman.Visible = False
predflg = True
predafterflg = False
fsubtsks.Caption = "SELECT THE INITIAL TASKS"
fsubtsks.Move 15, 16, fsubtsks1.Width, Abs(fsubtsks1.Height - 6)
subtsks.Width = subtsks1.Width
subtsks.Height = subtsks1.Height

End Sub

Private Sub subtsks_Click()
 If predflg = True Then
    canceltsk.Enabled = True
    savetsk.Enabled = True
 End If
 
End Sub



Private Sub tskdesc_KeyPress(pKey As Integer)
If pKey = vbKeyBack Then
    pKey = vbKeyBack
    Exit Sub
End If
canceltsk.Enabled = True
savetsk.Enabled = True
End Sub

Private Sub tskdur_KeyPress(pKey As Integer)
If pKey = 13 Then
    If Val(tskdur) > 0 Then
        cselectid.SetFocus
        
    Else
        MsgBox "INVALID TASK DURATION", vbOKCancel, "DURATION ERROR"
        tskdur.SetFocus
    End If
    
Exit Sub
End If

If pKey = vbKeyBack Then Exit Sub

If pKey < 48 Or pKey > 57 Then
    pKey = 0
    Exit Sub
End If
canceltsk.Enabled = True
savetsk.Enabled = True
End Sub

Private Sub tskname_KeyPress(pKey As Integer)

If pKey = 13 Then
    If Trim(tskname) <> "" Then
        tskdesc.SetFocus
        
    Else
        MsgBox "INVALID TASK NAME", vbOKCancel, "DESCRIPTION ERROR"
        tskname.SetFocus
    End If
    
Exit Sub
End If

If pKey = vbKeyBack Then Exit Sub
canceltsk.Enabled = True
savetsk.Enabled = True
End Sub
