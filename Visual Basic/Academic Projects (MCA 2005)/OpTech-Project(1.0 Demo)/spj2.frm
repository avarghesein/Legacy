VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Begin VB.Form spj2 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Sequential Problem Solver (2-jobs K-machines)"
   ClientHeight    =   6045
   ClientLeft      =   540
   ClientTop       =   1830
   ClientWidth     =   11130
   HelpContextID   =   10
   Icon            =   "spj2.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8340
   ScaleWidth      =   11910
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      Height          =   375
      Left            =   10755
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "Saves the problem."
      Top             =   150
      Width           =   1065
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid sps 
      Height          =   2295
      Left            =   255
      TabIndex        =   1
      ToolTipText     =   "Shows the solution of the current Sequential Problem."
      Top             =   4920
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   4048
      _Version        =   393216
      BackColor       =   16777215
      ForeColor       =   0
      BackColorFixed  =   8421504
      ForeColorFixed  =   -2147483624
      BackColorBkg    =   -2147483644
      GridColor       =   16777215
      BorderStyle     =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
      _Band(0).TextStyleBand=   0
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid spp 
      Height          =   2175
      Left            =   345
      TabIndex        =   2
      ToolTipText     =   "Shows the current Sequential Problem."
      Top             =   825
      Width           =   11445
      _ExtentX        =   20188
      _ExtentY        =   3836
      _Version        =   393216
      BackColor       =   16777215
      ForeColor       =   0
      BackColorFixed  =   8421504
      ForeColorFixed  =   -2147483624
      BackColorBkg    =   -2147483644
      GridColor       =   16777215
      BorderStyle     =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
      _Band(0).TextStyleBand=   0
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Sequential Problem Solution"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   -105
      TabIndex        =   4
      Top             =   4530
      Width           =   2895
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Sequential Problem Definition"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   420
      Width           =   2895
   End
   Begin VB.Menu options 
      Caption         =   "&View"
      Begin VB.Menu showgraph 
         Caption         =   "Show Graph"
         Shortcut        =   ^G
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu showprblm 
         Caption         =   "Show Problem"
         Shortcut        =   ^P
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu showoptshed 
         Caption         =   "Show Optimal Schedule"
         Shortcut        =   ^S
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu showobtshed 
         Caption         =   "Show Obtained Schedules"
         Shortcut        =   ^O
      End
      Begin VB.Menu sep4 
         Caption         =   "-"
      End
      Begin VB.Menu mexit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
End
Attribute VB_Name = "spj2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public spj2id As Long
Public hold As Long

Private Sub cexit_Click()
    Unload Me
End Sub

Private Sub Form_load()
On Error GoTo xit
    Call load_spj2(spj2id, seqj2)
    Call create_spj2schedules(job_mx, seqj2)
    If job_mx.optimal_schedule = -1 Then
        showoptshed.Visible = False
        showobtshed.Visible = False
        showgraph.Visible = False
    Else
        Call create_idles(job_mx, job_mx.optimal_schedule, idles_t, seqj2)
        Call process_grids(job_mx, seqj2, job_mx.optimal_schedule)
    End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_Unload(cancel As Integer)
    If hold = 0 Then
        or_form1.Show
    ElseIf hold = 1 Then
        foptions.Show
    End If
End Sub

Private Sub process_grids(jm As job_matrix, s As seq_j2, k As Long)
On Error GoTo xit
Dim i As Integer
Dim j As Integer

spp.rows = 6
spp.cols = IIf(s.jd(0).cnt > s.jd(1).cnt, s.jd(0).cnt + 3, s.jd(1).cnt + 3)
For j = 0 To spp.cols - 1 Step 1
        spp.ColWidth(j) = 1500
Next j
For i = 0 To spp.rows - 1 Step 1
    For j = 0 To spp.cols - 1 Step 1
        spp.row = i
        spp.col = j
        spp.CellAlignment = 1
    Next j
Next i
spp.FixedCols = 0
spp.FixedRows = 0
spp.TextMatrix(0, 0) = "JOB1"
spp.TextMatrix(1, 1) = "MACHINES"
spp.TextMatrix(2, 1) = "TIME-NEEDED"
For i = 0 To s.jd(0).cnt Step 1
    spp.TextMatrix(1, i + 2) = "MAC-" & Trim(str(s.jd(0).job_mac(i) + 1))
    spp.TextMatrix(2, i + 2) = Trim(str(s.jd(0).job_dur(i)))
Next i

spp.TextMatrix(3, 0) = "JOB2"
spp.TextMatrix(4, 1) = "MACHINES"
spp.TextMatrix(5, 1) = "TIME-NEEDED"
For i = 0 To s.jd(1).cnt Step 1
    spp.TextMatrix(4, i + 2) = "MAC-" & Trim(str(s.jd(1).job_mac(i) + 1))
    spp.TextMatrix(5, i + 2) = Trim(str(s.jd(1).job_dur(i)))
Next i

If jm.optimal_schedule = -1 Then
    sps.rows = 1
    sps.cols = 1
    sps.ColWidth(0) = 3500
    sps.TextMatrix(0, 0) = "NO SOLUTION OBTAINED"
Else
    sps.rows = 6
    sps.cols = IIf(jm.jg(k).j(0).cnt > jm.jg(k).j(1).cnt, jm.jg(k).j(0).cnt + 3, jm.jg(k).j(1).cnt + 3)
    For j = 0 To sps.cols - 1 Step 1
        sps.ColWidth(j) = 1500
    Next j
    For i = 0 To sps.rows - 1 Step 1
        For j = 0 To sps.cols - 1 Step 1
            sps.row = i
            sps.col = j
            sps.CellAlignment = 1
        Next j
    Next i
    sps.FixedCols = 0
    sps.FixedRows = 0
    sps.TextMatrix(0, 0) = "JOB1"
    sps.TextMatrix(1, 1) = "TIME-SLOT"
    sps.TextMatrix(2, 1) = "UNDER"
    For i = 0 To jm.jg(k).j(0).cnt Step 1
        sps.TextMatrix(1, i + 2) = Trim(str(job_mx.jg(k).j(0).jp(i).low)) & "-" & Trim(str(job_mx.jg(k).j(0).jp(i).up))
        sps.TextMatrix(2, i + 2) = IIf(job_mx.jg(k).j(0).jp(i).process = -1, "IDLE", "MAC" & Trim(str(job_mx.jg(k).j(0).jp(i).process + 1)))
    Next i
    sps.TextMatrix(3, 0) = "JOB2"
    sps.TextMatrix(4, 1) = "TIME-SLOT"
    sps.TextMatrix(5, 1) = "UNDER"
    For i = 0 To jm.jg(k).j(1).cnt Step 1
        sps.TextMatrix(4, i + 2) = Trim(str(job_mx.jg(k).j(1).jp(i).low)) & "-" & Trim(str(job_mx.jg(k).j(1).jp(i).up))
        sps.TextMatrix(5, i + 2) = IIf(job_mx.jg(k).j(1).jp(i).process = -1, "IDLE", "MAC" & Trim(str(job_mx.jg(k).j(1).jp(i).process + 1)))
    Next i
End If
    
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub mexit_Click()
    Unload Me
End Sub

Private Sub showgraph_Click()
On Error GoTo xit
Dim gr As New grapher
    gr.indx = job_mx.optimal_schedule
    gr.hold = 0
    gr.Show vbModal, Me
    'Me.Hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub showobtshed_Click()
On Error GoTo xit
    mdi.hold = 2
    mdi.chois = "SPJ2"
    mdi.Show
    Me.Hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub showoptshed_Click()
On Error GoTo xit
    r.hold = 5
    r.flg = 1
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub showprblm_Click()
On Error GoTo xit
    r.hold = 5
    r.flg = 0
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub
