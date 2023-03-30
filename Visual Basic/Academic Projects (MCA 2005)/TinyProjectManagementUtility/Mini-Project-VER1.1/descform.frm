VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "mshflxgd.ocx"
Begin VB.Form descform 
   Caption         =   "AVAILABLE PROJECTS"
   ClientHeight    =   6060
   ClientLeft      =   810
   ClientTop       =   1680
   ClientWidth     =   10410
   Icon            =   "descform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6060
   ScaleWidth      =   10410
   Begin VB.Frame fsearch 
      Caption         =   "CHARACTERS FOR SEARCHING"
      Height          =   615
      Left            =   120
      TabIndex        =   26
      Top             =   3000
      Width           =   3975
      Begin VB.TextBox tpsearch 
         Height          =   285
         Left            =   120
         TabIndex        =   27
         Top             =   240
         Width           =   3735
      End
   End
   Begin VB.Frame ftasks 
      Caption         =   "SUBTASKS"
      Height          =   2295
      Left            =   5280
      TabIndex        =   15
      Top             =   3720
      Width           =   5055
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid flextasks 
         Height          =   1935
         Left            =   120
         TabIndex        =   25
         Top             =   240
         Width           =   4815
         _ExtentX        =   8493
         _ExtentY        =   3413
         _Version        =   393216
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
      End
   End
   Begin VB.Frame fprojects 
      Caption         =   "AVAILABLE PROJECTS"
      Height          =   2295
      Left            =   120
      TabIndex        =   14
      Top             =   3720
      Width           =   5055
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid flexproject 
         Height          =   1935
         Left            =   150
         TabIndex        =   24
         Top             =   240
         Width           =   4815
         _ExtentX        =   8493
         _ExtentY        =   3413
         _Version        =   393216
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
      End
   End
   Begin VB.Frame fsubtask 
      Caption         =   "SELECTED SUBTASK"
      Height          =   2775
      Left            =   6000
      TabIndex        =   1
      Top             =   240
      Width           =   4215
      Begin VB.CommandButton tcancel 
         Caption         =   "CANCEL"
         Height          =   375
         Left            =   2880
         TabIndex        =   13
         Top             =   360
         Width           =   975
      End
      Begin VB.CommandButton tsave 
         Caption         =   "SAVE"
         Height          =   375
         Left            =   1680
         TabIndex        =   12
         Top             =   360
         Width           =   1095
      End
      Begin VB.Frame ftdur 
         Caption         =   "DURATION"
         Height          =   615
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   1335
         Begin VB.TextBox tdur 
            Height          =   285
            Left            =   120
            TabIndex        =   21
            Top             =   240
            Width           =   1095
         End
      End
      Begin VB.Frame ftdesc 
         Caption         =   "TASK DESCRIPTION"
         Height          =   975
         Left            =   120
         TabIndex        =   10
         Top             =   1680
         Width           =   3975
         Begin VB.TextBox tdesc 
            Height          =   645
            Left            =   120
            MaxLength       =   195
            MultiLine       =   -1  'True
            TabIndex        =   23
            Top             =   240
            Width           =   3735
         End
      End
      Begin VB.Frame ftname 
         Caption         =   "TASK NAME"
         Height          =   615
         Left            =   120
         TabIndex        =   9
         Top             =   960
         Width           =   3975
         Begin VB.TextBox tname 
            Height          =   285
            Left            =   120
            TabIndex        =   22
            Top             =   240
            Width           =   3735
         End
      End
   End
   Begin VB.Frame fproject 
      Caption         =   "SELECTED PROJECT"
      Height          =   2775
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5295
      Begin VB.CommandButton cpcancel 
         Caption         =   "CANCEL"
         Height          =   375
         Left            =   4200
         TabIndex        =   8
         Top             =   2160
         Width           =   975
      End
      Begin VB.CommandButton cpsave 
         Caption         =   "SAVE"
         Height          =   375
         Left            =   4200
         TabIndex        =   7
         Top             =   1680
         Width           =   975
      End
      Begin VB.Frame fpstatus 
         Caption         =   "STATUS"
         Height          =   855
         Left            =   2640
         TabIndex        =   6
         Top             =   120
         Width           =   2535
         Begin VB.TextBox tpstatus 
            Height          =   525
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   18
            Top             =   240
            Width           =   2295
         End
      End
      Begin VB.Frame fpstart 
         Caption         =   "START DATE"
         Height          =   615
         Left            =   1200
         TabIndex        =   5
         Top             =   240
         Width           =   1335
         Begin VB.TextBox tpstart 
            Height          =   285
            Left            =   120
            TabIndex        =   17
            Top             =   240
            Width           =   1095
         End
      End
      Begin VB.Frame fpdesc 
         Caption         =   "PROJECT DESCRIPTION"
         Height          =   975
         Left            =   120
         TabIndex        =   4
         Top             =   1680
         Width           =   3975
         Begin VB.TextBox tpdesc 
            Height          =   645
            Left            =   120
            MaxLength       =   195
            MultiLine       =   -1  'True
            TabIndex        =   20
            Top             =   240
            Width           =   3735
         End
      End
      Begin VB.Frame fpname 
         Caption         =   "PROJECT NAME"
         Height          =   615
         Left            =   150
         TabIndex        =   3
         Top             =   960
         Width           =   3975
         Begin VB.TextBox tpname 
            Height          =   285
            Left            =   150
            TabIndex        =   19
            Top             =   240
            Width           =   3735
         End
      End
      Begin VB.Frame fpid 
         Caption         =   "ID"
         Height          =   615
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   975
         Begin VB.TextBox tpid 
            Height          =   285
            Left            =   120
            TabIndex        =   16
            Top             =   240
            Width           =   735
         End
      End
   End
   Begin VB.Menu option 
      Caption         =   "OPTIONS"
      Begin VB.Menu pnamelike 
         Caption         =   "PROJECTS-WITH-NAME-LIKE"
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu pedit 
         Caption         =   "PROJECT-DESCRIPTION-EDIT"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu tedit 
         Caption         =   "TASK-DESCRIPTION-EDIT"
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu exit 
         Caption         =   "EXIT"
      End
   End
End
Attribute VB_Name = "descform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim search_flg As Boolean

Private Sub disable_all()
Dim I As Integer

For I = 0 To Me.Count - 1
    If Not TypeOf Me.Controls(I) Is Menu Then
        Me.Controls(I).Enabled = False
    End If
Next I
End Sub

Private Sub cpcancel_Click()
    Call Form_Load
End Sub

Private Sub tsave_Click()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

If tpid <> 0 And Trim(tname) <> "" Then
    Set Y = X.Execute("select * from subtasks where(projid=" & Val(tpid) & " and taskname='" & tname & "')")
    If Not Y.EOF And Not Y.BOF Then
        Y.Close
        Set Y = X.Execute("select taskid from subtasks where(projid=" & Val(tpid) & " and taskname='" & tname & "')")
        Y.MoveFirst
        X.BeginTrans
        X.Execute "update subtasks set taskdesc='" & Trim(tdesc) & "' where (projid=" & Val(tpid) & " and taskid=" & Val(Y("taskid")) & ")"
        X.CommitTrans
        Call tcancel_Click
    End If
End If

Exit Sub
    
cancel:
    MsgBox Err.Description
End Sub
Private Sub cpsave_Click()
Dim X As New Connection

Set X = dn.cn
If X.State = 0 Then X.Open

If tpid <> 0 Then
    X.BeginTrans
    X.Execute "update projects set projdesc='" & Trim(tpdesc) & "' where projid=" & Val(tpid) & ""
    X.CommitTrans
    Call Form_Load
End If

Exit Sub
    
cancel:
    MsgBox Err.Description
   
End Sub

Private Sub exit_Click()
    Unload Me
End Sub

Private Sub flexproject_Click()
tname = ""
tdesc = ""
tdur = ""
flextasks.clear
        fproject.Enabled = False
        fsubtask.Enabled = False
        ftdesc.Enabled = False
        tdesc.Enabled = False
        tsave.Enabled = False
        tcancel.Enabled = False
        fpdesc.Enabled = False
        tpdesc.Enabled = False
        cpsave.Enabled = False
        cpcancel.Enabled = False
    With flexproject
        .cols = 7
        If .Row > 0 Then
            tpname = .TextMatrix(.Row, 2)
            tpid = .TextMatrix(.Row, 1)
            tpdesc = Trim(.TextMatrix(.Row, 3))
            tpstart = .TextMatrix(.Row, 4)
            tpstatus = IIf(.TextMatrix(.Row, 5) = "F", "Not Completed" & vbCrLf, "Completed" & vbCrLf)
            tpstatus = tpstatus & IIf(.TextMatrix(.Row, 6) = "F", "Active Project", "Deleted Project")
            Call loadsubtasks(Val(tpid))
        Else
            tpname = ""
            tpid = ""
            tpdesc = ""
            tpstart = ""
            tpstatus = ""
            tpstatus = ""
        End If
    End With
    
End Sub

Private Sub flextasks_Click()
        fproject.Enabled = False
        fsubtask.Enabled = False
        ftdesc.Enabled = False
        tdesc.Enabled = False
        tsave.Enabled = False
        tcancel.Enabled = False
        fpdesc.Enabled = False
        tpdesc.Enabled = False
        cpsave.Enabled = False
        cpcancel.Enabled = False
    With flextasks
        .cols = 4
        If .Row > 0 Then
            tname = .TextMatrix(.Row, 1)
            tdesc = Trim(.TextMatrix(.Row, 2))
            tdur = .TextMatrix(.Row, 3)
        Else
            tname = ""
            tdesc = ""
            tdur = ""
        End If
    End With
End Sub

Private Sub Form_Load()
    Call disable_all
    search_flg = True
    Call pnamelike_Click
    Call loadprojects
End Sub

Private Static Sub loadprojects()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open
tpname = ""
tpid = ""
tpdesc = ""
tpstart = ""
tpstatus = ""
tpstatus = ""
tname = ""
tdesc = ""
tdur = ""
flextasks.clear
flextasks.rows = 2
flextasks.cols = 2
flextasks.FixedRows = 1
flextasks.FixedCols = 1

flexproject.clear
If search_flg = False Then
    Set Y = X.Execute("select projid as project_id,projname as project_name,projdesc as description," & _
        "projstartdate as startdaate,completed,deleted from projects")
Else
    Set Y = X.Execute("select projid as project_id,projname as project_name,projdesc as description," & _
        "projstartdate as startdaate,completed,deleted from projects where projname like '" & tpsearch & "%'")
End If

If Y.EOF And Y.BOF Then
    flexproject.Enabled = False
    flexproject.rows = 2
    flexproject.FixedRows = 1
    flexproject.cols = Y.Fields.Count + 1
    flexproject.FixedCols = 1
    Exit Sub
End If
    flexproject.Enabled = True
    fprojects.Enabled = True
    flexproject.Enabled = True
    flexproject.rows = 15
    flexproject.FixedRows = 1
    flexproject.cols = Y.Fields.Count + 1
    flexproject.FixedCols = 1
    flexproject.ColWidth(2) = 2000
    flexproject.ColWidth(3) = 2500
    flexproject.ColWidth(1) = 1000
    flexproject.ColWidth(5) = 1000
    flexproject.ColWidth(6) = 1000
    Set flexproject.Recordset = Y
    Exit Sub
    
cancel:
    MsgBox Err.Description
    
End Sub

Private Sub Form_Unload(cancel As Integer)
    adminform.Show
End Sub

Private Sub loadsubtasks(pid As Long)
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

If pid = 0 Then
    Exit Sub
End If

Set Y = X.Execute("select taskname,taskdesc,taskduration as duration from subtasks where projid=" & pid & "")
tname = ""
tdesc = ""
tdur = ""
flextasks.clear
If Y.EOF And Y.BOF Then
    flextasks.Enabled = False
    flextasks.rows = 2
    flextasks.FixedRows = 1
    flextasks.cols = Y.Fields.Count + 1
    flextasks.FixedCols = 1
    Exit Sub
End If
    flextasks.Enabled = True
    ftasks.Enabled = True
    flextasks.Enabled = True
    flextasks.rows = 15
    flextasks.FixedRows = 1
    flextasks.cols = Y.Fields.Count + 1
    flextasks.FixedCols = 1
    flextasks.ColWidth(1) = 2000
    flextasks.ColWidth(2) = 2500
    flextasks.ColWidth(3) = 1000
    Set flextasks.Recordset = Y
    Exit Sub
    
cancel:
    MsgBox Err.Description
End Sub

Private Sub pedit_Click()
        fsubtask.Enabled = False
        ftdesc.Enabled = False
        tdesc.Enabled = False
        tsave.Enabled = False
        tcancel.Enabled = False
    If Val(tpid) <> 0 Then
        fproject.Enabled = True
        fpdesc.Enabled = True
        tpdesc.Enabled = True
        cpsave.Enabled = True
        cpcancel.Enabled = True
    End If
End Sub

Private Sub pnamelike_Click()
        fproject.Enabled = False
        fsubtask.Enabled = False
        ftdesc.Enabled = False
        tdesc.Enabled = False
        tsave.Enabled = False
        tcancel.Enabled = False
        fpdesc.Enabled = False
        tpdesc.Enabled = False
        cpsave.Enabled = False
        cpcancel.Enabled = False
    search_flg = Not search_flg
    If search_flg Then
        fsearch.Enabled = True
        tpsearch.Enabled = True
        tpsearch = ""
        pnamelike.Checked = True
        tpsearch.SetFocus
    Else
        pnamelike.Checked = False
        fsearch.Enabled = False
        tpsearch.Enabled = False
        tpsearch = ""
    End If
    
End Sub

Private Sub tcancel_Click()
        Call loadsubtasks(Val(tpid))
        fsubtask.Enabled = False
        ftdesc.Enabled = False
        tdesc.Enabled = False
        tsave.Enabled = False
        tcancel.Enabled = False
End Sub

Private Sub tedit_Click()
        fproject.Enabled = False
        fpdesc.Enabled = False
        tpdesc.Enabled = False
        cpsave.Enabled = False
        cpcancel.Enabled = False
    If Val(tpid) <> 0 And Trim(tname) <> "" Then
        fsubtask.Enabled = True
        ftdesc.Enabled = True
        tdesc.Enabled = True
        tsave.Enabled = True
        tcancel.Enabled = True
    End If

End Sub

Private Sub tpsearch_Change()
        fproject.Enabled = False
        fsubtask.Enabled = False
        ftdesc.Enabled = False
        tdesc.Enabled = False
        tsave.Enabled = False
        tcancel.Enabled = False
        fpdesc.Enabled = False
        tpdesc.Enabled = False
        cpsave.Enabled = False
        cpcancel.Enabled = False
    Call loadprojects
End Sub


