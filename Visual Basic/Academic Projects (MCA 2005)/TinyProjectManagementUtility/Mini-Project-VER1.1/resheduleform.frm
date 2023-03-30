VERSION 5.00
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form resheduleform 
   Caption         =   "RESCHEDULER"
   ClientHeight    =   6210
   ClientLeft      =   1065
   ClientTop       =   1770
   ClientWidth     =   9855
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "resheduleform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6210
   ScaleWidth      =   9855
   Begin VB.Frame fnewtask 
      Caption         =   "NEW SUBTASK ENTRY DETAILS"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3615
      Left            =   1380
      TabIndex        =   12
      Top             =   2280
      Width           =   7095
      Begin VB.TextBox tskdur 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   2880
         MaxLength       =   30
         TabIndex        =   15
         Top             =   2040
         Width           =   2055
      End
      Begin VB.TextBox tskman 
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
         Left            =   2880
         Locked          =   -1  'True
         MaxLength       =   7
         TabIndex        =   16
         Top             =   2400
         Width           =   2055
      End
      Begin VB.TextBox tskname 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   2880
         MaxLength       =   30
         TabIndex        =   13
         Top             =   360
         Width           =   2535
      End
      Begin VB.CommandButton savetsk 
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
         Left            =   4800
         TabIndex        =   18
         Top             =   3120
         Width           =   975
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
         Height          =   375
         Left            =   5880
         TabIndex        =   19
         Top             =   3120
         Width           =   975
      End
      Begin VB.TextBox tskdesc 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1335
         Left            =   2880
         MaxLength       =   195
         MultiLine       =   -1  'True
         TabIndex        =   14
         Top             =   720
         Width           =   2535
      End
      Begin VB.CommandButton cselectid 
         Caption         =   "SELECT ID"
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
         Left            =   5040
         TabIndex        =   17
         Top             =   2400
         Width           =   1095
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
         Left            =   720
         TabIndex        =   23
         Top             =   360
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
         Left            =   720
         TabIndex        =   22
         Top             =   2040
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
         Left            =   720
         TabIndex        =   21
         Top             =   2400
         Width           =   2055
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
         Left            =   720
         TabIndex        =   20
         Top             =   1200
         Width           =   2055
      End
   End
   Begin VB.Frame fdur 
      Caption         =   "RECALCULATED DURATION"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   4305
      TabIndex        =   8
      Top             =   1238
      Width           =   4575
      Begin VB.CommandButton durnok 
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
         Left            =   3480
         TabIndex        =   11
         Top             =   240
         Width           =   975
      End
      Begin VB.CommandButton durok 
         Caption         =   "OK"
         Height          =   375
         Left            =   2400
         TabIndex        =   10
         Top             =   240
         Width           =   975
      End
      Begin VB.TextBox tdur 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   2055
      End
   End
   Begin VB.Frame fpage 
      Caption         =   "SET NEW START DATE"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   4305
      TabIndex        =   2
      Top             =   398
      Width           =   4575
      Begin VB.CommandButton dnok 
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
         Left            =   3480
         TabIndex        =   5
         Top             =   240
         Width           =   975
      End
      Begin VB.CommandButton dok 
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
         Left            =   2400
         TabIndex        =   4
         Top             =   240
         Width           =   975
      End
      Begin MSComCtl2.DTPicker tpage 
         Height          =   375
         Left            =   240
         TabIndex        =   3
         Top             =   240
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   661
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   61210625
         CurrentDate     =   37987.3958333333
      End
   End
   Begin VB.Frame fsubtsks 
      Caption         =   "SELECT TASK ID"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   705
      Left            =   945
      TabIndex        =   6
      Top             =   1238
      Width           =   2745
      Begin VB.ComboBox taskname 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   240
         Width           =   2535
      End
   End
   Begin VB.Frame fprojectid 
      Caption         =   "SELECT PROJECT ID"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   705
      Left            =   945
      TabIndex        =   0
      Top             =   398
      Width           =   2745
      Begin VB.ComboBox projectid 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   240
         Width           =   2445
      End
   End
   Begin VB.Menu exitre 
      Caption         =   "EXIT-RESCHEDULER!"
   End
End
Attribute VB_Name = "resheduleform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public sel_cde As Long
Public sel_nam As String
Public chois As String

Private Sub canceltsk_Click()
    Call reloadtables
End Sub

Private Sub cselectid_Click()
    personform.person_chois = "SELECT"
    personform.owner = "RESHEDULER"
    Me.Hide
    personform.Show
End Sub

Private Sub dnok_Click()
    Call reloadtables
End Sub

Private Sub dok_Click()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset
Set X = dn.cn

If projectid.ListIndex = -1 Then
    MsgBox "SELECT ANY PROJECT-ID AND RETRY", vbOKOnly, "SELECTION ERROR!!!"
    Exit Sub
End If
If MsgBox("ARE YOU SURE TO ALTER THE STARTING DATE OF THE PROJECT", vbYesNo, "CONFIRM") = vbNo Then
    Exit Sub
End If
glob_proj.pstart = tpage.Value
If X.State = 0 Then X.Open

X.BeginTrans

X.Execute "update tmp_projects set projstartdate='" & Format$(Str(tpage.Value), "dd-mmm-yyyy") & _
    "' where projid=" & Val(projectid.Text) & ""
X.Execute "update tmp_projectsassignedto set assigneddate='" & Format$(Str(tpage.Value), "dd-mmm-yyyy") & _
    "' where projid=" & Val(projectid.Text) & ""

Call re_earlylatestarts_settings(Val(projectid.Text))
Call save_resheduled(Val(projectid.Text))

Call dnok_Click
Exit Sub
cancel:
    MsgBox Err.Description
    Call dnok_Click
End Sub

Private Sub durnok_Click()
    Call reloadtables
End Sub

Private Sub durok_Click()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset
Set X = dn.cn

If taskname.ListIndex = -1 Then
    MsgBox "SELECT ANY TASKNAME AND RETRY", vbOKOnly, "SELECTION ERROR!!!"
    Exit Sub
End If
If Val(tdur) = 0 Then
    MsgBox "ERROR IN DURATION,IT CANNOT BE ZERO", vbOKOnly, "ERROR IN DURATION!!!"
    Exit Sub
End If

If MsgBox("ARE YOU SURE TO ALTER THE DURATION OF THE TASK", vbYesNo, "CONFIRM") = vbNo Then
    Exit Sub
End If

If X.State = 0 Then X.Open
Set Y = X.Execute("select projstartdate from projects where projid=" & Val(projectid.Text) & "")
Y.MoveFirst

glob_proj.pstart = DateValue(Format$(Y("projstartdate"), "mm/dd/yyyy"))

X.Execute "update tmp_subtasks set taskduration=" & Val(tdur) & " where(projid=" & Val(projectid.Text) & " and taskid=" & taskname.ItemData(taskname.ListIndex) & ")"
X.BeginTrans

Call re_earlylatestarts_settings(Val(projectid.Text))
Call save_resheduled(Val(projectid.Text))

Call durnok_Click
Exit Sub
cancel:
    MsgBox Err.Description
    Call durnok_Click
End Sub

Private Sub exitre_Click()
    Unload Me
End Sub

Private Sub Form_Load()
Call create_tmp_tables(True)
Call reloadtables
End Sub

Private Sub Form_Unload(cancel As Integer)
    chois = ""
    Call create_tmp_tables(False)
    adminform.Show
End Sub

Private Sub projectid_Click()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
 taskname.clear
 If projectid.ListIndex <> -1 Then
    Call reshedule(Val(projectid.Text))
    If X.State = 0 Then X.Open
    If chois = "PSC" Then
        fpage.Enabled = True
        tpage.Enabled = True
        dok.Enabled = True
        dnok.Enabled = True
    Else
        If chois = "TSC" Then
            fsubtsks.Enabled = True
            taskname.Enabled = True
            Set Y = X.Execute("select taskname,taskid from tmp_subtasks where (projid=" & Val(projectid.Text) & " and taskid not in(" & _
             " select distinct(taskid) from tmp_projectinprogress where(projid=" & Val(projectid.Text) & " and enddate is not null)))")
            Call addtocombobox_extended(taskname, Y, "taskname", "taskid")
            taskname.SetFocus
        Else
            fnewtask.Enabled = True
            tskname.Enabled = True
            tskname.SetFocus
            tskdesc.Enabled = True
            tskdur.Enabled = True
            tskman.Enabled = True
            cselectid.Enabled = True
            savetsk.Enabled = True
            canceltsk.Enabled = True
            ltname.Enabled = True
            ltdesc.Enabled = True
            ltduration.Enabled = True
            ltman.Enabled = True
        End If
     End If
 Else
    MsgBox "SELECT ANY PROJECT-ID AND RETRY", vbOKOnly, "SELECTION ERROR!!!"
 End If

Exit Sub
cancel:
    MsgBox Err.Description
End Sub

Private Sub clear()
Dim I As Integer

For I = 0 To Me.Count - 1
   Me.Controls(I).Enabled = False
   If TypeOf Me.Controls(I) Is TextBox Then
          Me.Controls(I).Text = ""
   Else
        If TypeOf Me.Controls(I) Is ComboBox Then
            Me.Controls(I).clear
        End If
   End If
Next I
exitre.Enabled = True

End Sub

Private Sub savetsk_Click()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset
Set X = dn.cn
   
    
    If Trim(tskname) = "" Then
        MsgBox "INVALID TASK NAME", vbOKOnly, "ERROR IN TASK-NAME!!!"
        tskname.SetFocus
        Exit Sub
    End If
 
    If insubtasks(Val(projectid.Text), Trim(tskname), "tmp_subtasks") Then
        MsgBox "ANOTHER TASK WITH THE SAME NAME EXSISTS,RENAME THE TASK", vbOKOnly, "DUPLICATE TASK NAME"
        tskname.SetFocus
        Exit Sub
    End If

    If Val(tskdur) = 0 Then
        MsgBox "INVALID DURATION", vbOKOnly, "ERROR IN NUMERIC FIELD!!!"
        tskdur.SetFocus
        Exit Sub
    End If

    If Val(tskman) = 0 Then
        MsgBox "NO MANAGER SELECTED,SELECT ONE", vbOKOnly, "ERROR IN MANAGER SELECTION!!!"
        cselectid.SetFocus
        Exit Sub
    End If
    
    If X.State = 0 Then X.Open
    Set Y = X.Execute("select projstartdate from projects where projid=" & Val(projectid.Text) & "")
    Y.MoveFirst
    glob_proj.pstart = DateValue(Format$(Y("projstartdate"), "mm/dd/yyyy"))
    glob_proj.pid = Val(projectid.Text)
    glob_task.pid = Val(projectid.Text)
    glob_task.tdesc = Trim(tskdesc)
    glob_task.tid = getmaxid("taskid", "tmp_subtasks", glob_task.pid, True)
    glob_task.tmanager = Val(tskman)
    glob_task.tnam = Trim(tskname)
    glob_task.tdur = Val(tskdur)

    Me.Hide
    reshedulesub.Show
    
Exit Sub
cancel:
    MsgBox Err.Description
    Call durnok_Click
End Sub

Private Sub taskname_Click()
If taskname.ListIndex <> -1 Then
    If chois = "TSC" Then
         fdur.Enabled = True
         tdur.Enabled = True
         durok.Enabled = True
         durnok.Enabled = True
    End If
Else
    MsgBox "SELECT ANY TASKNAME AND RETRY", vbOKOnly, "SELECTION ERROR!!!"
End If
End Sub

Public Sub reloadtables()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open
Call clear

    X.Execute "delete from tmp_projectinprogress"
    X.Execute "delete from tmp_subtasksassignedto"
    X.Execute "delete from tmp_projectsassignedto"
    X.Execute "delete from tmp_successortasks"
    X.Execute "delete from tmp_predecessortasks"
    X.Execute "delete from tmp_subtasks"
    X.Execute ("delete from tmp_projects")
If chois = "PSC" Then
    X.Execute "insert into tmp_projects(projid,projname,projdesc," & _
          "projduration,projstartdate,projmanager,completed,deleted)" & _
          " select * from projects where(deleted='F' and completed='F' " & _
          " and projid not in(select distinct(projid) from projectinprogress where" & _
          " startdate is not null))"
End If

If chois = "TSC" Or chois = "NTE" Then
    X.Execute "insert into tmp_projects(projid,projname,projdesc," & _
          "projduration,projstartdate,projmanager,completed,deleted)" & _
          " select * from projects where(deleted='F' and completed='F') "
End If
fprojectid.Enabled = True
projectid.Enabled = True
Set Y = X.Execute("select projid from tmp_projects")
Call addtocombobox(projectid, Y, "projid")

Exit Sub
cancel:
    MsgBox Err.Description
End Sub



Private Sub tdur_KeyPress(pKey As Integer)
  If personform.check_textbox(tdur, pKey, True, durok) = False Then
        MsgBox "INVALID DURATION", vbOKOnly, "ERROR IN NUMERIC FIELD!!!"
  End If
End Sub



Private Sub tskdur_KeyPress(pKey As Integer)
 If personform.check_textbox(tskdur, pKey, True, cselectid) = False Then
        MsgBox "INVALID DURATION", vbOKOnly, "ERROR IN NUMERIC FIELD!!!"
 End If
End Sub


Private Sub tskname_KeyPress(pKey As Integer)

If personform.check_textbox(tskname, pKey, False, tskdesc) = False Then
     MsgBox "INVALID TASK NAME", vbOKOnly, "ERROR IN TASK-NAME!!!"
Else
  If pKey = 13 Then
    If insubtasks(Val(projectid.Text), Trim(tskname), "tmp_subtasks") Then
        MsgBox "ANOTHER TASK WITH THE SAME NAME EXSISTS,RENAME THE TASK", vbOKOnly, "DUPLICATE TASK NAME"
        tskname.SetFocus
    End If
  End If
End If
End Sub
