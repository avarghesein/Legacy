VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Begin VB.Form matx1 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Matrix Attributes"
   ClientHeight    =   6735
   ClientLeft      =   540
   ClientTop       =   1830
   ClientWidth     =   11595
   HelpContextID   =   13
   Icon            =   "matx1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6735
   ScaleWidth      =   11595
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.Frame Frame3 
      Height          =   45
      Left            =   75
      TabIndex        =   11
      Top             =   7230
      Width           =   11850
   End
   Begin VB.Frame Frame2 
      Height          =   45
      Left            =   90
      TabIndex        =   10
      Top             =   1410
      Width           =   11820
   End
   Begin VB.Frame Frame1 
      Height          =   45
      Left            =   60
      TabIndex        =   9
      Top             =   5640
      Width           =   11850
   End
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      Height          =   375
      Left            =   10890
      Style           =   1  'Graphical
      TabIndex        =   8
      ToolTipText     =   "Exit to main menu"
      Top             =   360
      Width           =   975
   End
   Begin VB.Frame fmin 
      BackColor       =   &H80000004&
      Caption         =   "Select (i,j) for Minor(i,j) or M(i,j)"
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   5640
      TabIndex        =   6
      ToolTipText     =   "Select (i,j) for finding Minor(i,j) or M(i,j)."
      Top             =   240
      Width           =   3135
      Begin VB.ComboBox combomin 
         BackColor       =   &H80000004&
         ForeColor       =   &H80000002&
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   7
         ToolTipText     =   "Select (i,j) for finding Minor(i,j) or M(i,j)."
         Top             =   240
         Width           =   2895
      End
   End
   Begin VB.Frame fpid 
      BackColor       =   &H80000004&
      Caption         =   "Select Options"
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   75
      TabIndex        =   2
      ToolTipText     =   "Possible options for Matrices."
      Top             =   240
      Width           =   4095
      Begin VB.ComboBox combopid 
         BackColor       =   &H80000004&
         ForeColor       =   &H80000002&
         Height          =   315
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   3
         ToolTipText     =   "Possible options for Matrices."
         Top             =   240
         Width           =   3855
      End
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid gmatx 
      Height          =   4095
      Left            =   120
      TabIndex        =   1
      ToolTipText     =   "Shows different kind of matrices."
      Top             =   1470
      Width           =   11745
      _ExtentX        =   20717
      _ExtentY        =   7223
      _Version        =   393216
      BackColor       =   16777215
      ForeColor       =   0
      BackColorFixed  =   8421504
      ForeColorFixed  =   -2147483624
      BackColorBkg    =   -2147483644
      GridColor       =   -2147483624
      GridLines       =   0
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
      BeginProperty FontFixed {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
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
   Begin VB.Label l3 
      BackStyle       =   0  'Transparent
      Caption         =   "matx"
      ForeColor       =   &H80000002&
      Height          =   1275
      Left            =   135
      TabIndex        =   5
      ToolTipText     =   "Shows differant attributes of the Matrix"
      Top             =   5745
      Width           =   11295
   End
   Begin VB.Label l2 
      BackStyle       =   0  'Transparent
      Caption         =   "matx"
      ForeColor       =   &H80000002&
      Height          =   255
      Left            =   5400
      TabIndex        =   4
      ToolTipText     =   "Shows determinant of the Matrix."
      Top             =   1080
      Width           =   4455
   End
   Begin VB.Label l1 
      BackStyle       =   0  'Transparent
      Caption         =   "matx"
      ForeColor       =   &H80000002&
      Height          =   255
      Left            =   75
      TabIndex        =   0
      ToolTipText     =   "Shows the current option."
      Top             =   1095
      Width           =   3855
   End
   Begin VB.Menu opts 
      Caption         =   "&View"
      Begin VB.Menu tmatx 
         Caption         =   "The Matrix"
         Shortcut        =   ^M
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu iotm 
         Caption         =   "Determinant And Inverse Of The Matrix"
         Shortcut        =   ^I
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu aotm 
         Caption         =   "Adjoint Of The Matrix"
         Shortcut        =   ^A
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu rcfotm 
         Caption         =   "Row Canonical Form Of The Matrix"
         Shortcut        =   ^R
      End
      Begin VB.Menu sep4 
         Caption         =   "-"
      End
      Begin VB.Menu totm 
         Caption         =   "Transpos Of The Matrix"
         Shortcut        =   ^T
      End
      Begin VB.Menu sep5 
         Caption         =   "-"
      End
      Begin VB.Menu cotm 
         Caption         =   "Cofactor Of The Matrix"
         Shortcut        =   ^C
      End
      Begin VB.Menu sep6 
         Caption         =   "-"
      End
      Begin VB.Menu motm 
         Caption         =   "Minor Of The Matrix"
         Shortcut        =   ^O
      End
      Begin VB.Menu sep7 
         Caption         =   "-"
      End
      Begin VB.Menu mexit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
End
Attribute VB_Name = "matx1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public id_ As Long
Public hold As Long
Dim minij() As rat
Dim adj As matrix
Dim inv As matrix
Dim org As matrix
Dim rcm As matrix
Dim tpos As matrix
Dim t1 As matrix
Dim t2 As matrix
Dim t3 As matrix
Dim coff As matrix
Dim det As rat



Private Sub aotm_Click()
On Error GoTo xit
    tmp2_matx = adj
    tmp1_matx = org
    r.hold = 6
    r.flg = 2
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub cexit_Click()
    Unload Me
End Sub

Private Sub combomin_Click()
On Error GoTo xit
Dim i As Long
Dim j As Long
    
    If combomin.ListIndex <> -1 Then
        i = minij(combomin.ListIndex).a
        j = minij(combomin.ListIndex).b
        Call minorof(org.matx, i, j, org.rows, org.cols, t3.matx, t3.rows, t3.cols)
        Call map_matrix_grid(t3, gmatx)
        gmatx.TextMatrix(0, 0) = "MINOR" + combomin.List(combomin.ListIndex)
        motm.Enabled = True
    End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub combopid_Click()
On Error GoTo xit

    With combopid
    If combopid.ListIndex <> -1 Then
        fmin.Visible = False
        motm.Enabled = False
        If .ListIndex = 0 Then
            l1.Caption = "Matrix Selected"
            Call map_matrix_grid(org, gmatx)
            gmatx.TextMatrix(0, 0) = "Matrix Selected"
        End If
        If .ListIndex = 1 Then
            If rat_neq0(rat_stg(det)) And org.rows = org.cols And org.rows >= 1 And org.cols >= 1 Then
                l1.Caption = "Inverse Of The Matrix"
                Call map_matrix_grid(inv, gmatx)
                gmatx.TextMatrix(0, 0) = "Inverse Matrix"
            Else
                l1.Caption = "Inverse Of The Matrix"
                gmatx.rows = 1
                gmatx.cols = 1
                gmatx.ColWidth(0) = 5500
                gmatx.TextMatrix(0, 0) = "No Inverse exists, Since Determinant=0/Rows<>Cols"
            End If
        End If
        If .ListIndex = 2 Then
            If org.rows = org.cols And org.rows > 1 And org.cols > 1 Then
                l1.Caption = "Adjoint Of The Matrix"
                Call map_matrix_grid(adj, gmatx)
                gmatx.TextMatrix(0, 0) = "Adjoint Matrix"
            Else
                l1.Caption = "Adjoint Of The Matrix"
                gmatx.rows = 1
                gmatx.cols = 1
                gmatx.ColWidth(0) = 5000
                gmatx.TextMatrix(0, 0) = "No Adjoint Matrix"
            End If
        End If
        If .ListIndex = 3 Then
            l1.Caption = "Row Canonical Form Of The Matrix"
            Call map_matrix_grid(rcm, gmatx)
            gmatx.TextMatrix(0, 0) = "Rank=" + Trim(str(org.rank))
        End If
        If .ListIndex = 4 Then
            l1.Caption = "Transpos Of The Matrix"
            Call map_matrix_grid(tpos, gmatx)
            gmatx.TextMatrix(0, 0) = "Transpos Matrix"
        End If
        If .ListIndex = 5 Then
            If org.rows = org.cols And org.rows > 1 And org.cols > 1 Then
                l1.Caption = "Cofactor Of The Matrix"
                Call map_matrix_grid(coff, gmatx)
                gmatx.TextMatrix(0, 0) = "Cofactor Matrix"
            Else
                l1.Caption = "Cofactor Of The Matrix"
                gmatx.rows = 1
                gmatx.cols = 1
                gmatx.ColWidth(0) = 5000
                gmatx.TextMatrix(0, 0) = "No Cofactor Matrix"
            End If
        End If
        If .ListIndex = 6 Then
            If org.rows <= 1 Or org.cols <= 1 Then
                l1.Caption = "Minor Of The Matrix"
                gmatx.rows = 1
                gmatx.cols = 1
                gmatx.ColWidth(0) = 5000
                gmatx.TextMatrix(0, 0) = "No Minor Matrix"
            Else
                l1.Caption = "Minor Of The Matrix"
                fmin.Visible = True
                combomin.ListIndex = 0
                Call combomin_Click
            End If
        End If
    End If
    End With

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub cotm_Click()
On Error GoTo xit
    tmp2_matx = coff
    tmp1_matx = org
    r.hold = 6
    r.flg = 5
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_load()
On Error GoTo xit
Dim i As Long
Dim j As Long
Dim k As Long
    
    fmin.Visible = False
    motm.Enabled = False
    combopid.clear
    Call combopid.AddItem("Matrix Selected", 0)
    Call combopid.AddItem("Inverse Of The Matrix", 1)
    Call combopid.AddItem("Adjoint Of The Matrix", 2)
    Call combopid.AddItem("Row Canonical Representation Of The Matrix", 3)
    Call combopid.AddItem("Transpose Of The Matrix", 4)
    Call combopid.AddItem("Cofactor Of The Matrix", 5)
    Call combopid.AddItem("Minor Of The Matrix", 6)
    Call create_matrix(id_, org)
    ReDim minij(org.rows * org.cols) As rat
    k = 0
    For i = 1 To org.rows Step 1
        For j = 1 To org.cols Step 1
            Call combomin.AddItem("(" + Trim(str(i)) + "," + Trim(str(j)) + ")", k)
            minij(k).a = i - 1
            minij(k).b = j - 1
            k = k + 1
        Next j
    Next i
    det = detof(org.matx, org.rows, org.cols)
    Call invof(org.matx, org.rows, org.cols, inv.matx, inv.rows, inv.cols)
    Call adjof(org.matx, org.rows, org.cols, adj.matx, adj.rows, adj.cols)
    Call transposeof(org.matx, org.rows, org.cols, tpos.matx, tpos.rows, tpos.cols)
    Call transposeof(adj.matx, adj.rows, adj.cols, coff.matx, coff.rows, coff.cols)
    org.rank = rowcanonicalmatxof(org.matx, org.rows, org.cols, rcm.matx, rcm.rows, rcm.cols)
    l2.Caption = "Determinant Of the Matrix: " + rat_stg(det)
    combopid.ListIndex = 0
    Call combopid_Click
    l3.Caption = "ATTRIBUTES OF THE MATRIX:" + vbCrLf + vbCrLf
    Call matmul(org.matx, org.rows, org.cols, org.matx, org.rows, org.cols, t1.matx, t1.rows, t1.cols)
    If isequalmatrices(t1, org) Then
        l3.Caption = l3.Caption + "     The Matrix is IDEMPOTENT."
    End If
    Call matmul(t1.matx, t1.rows, t1.cols, org.matx, org.rows, org.cols, t2.matx, t2.rows, t2.cols)
    If matrixequaltoconst(t2, "0") Then
        l3.Caption = l3.Caption + "The Matrix is NIL POTENT."
    End If
    If isequalmatrices(org, tpos) Then
        l3.Caption = l3.Caption + "The Matrix is SYMMETRIC."
    End If
    If const_matmul(org, "-1", t1) Then
        If isequalmatrices(tpos, t1) Then
            l3.Caption = l3.Caption + "The Matrix is SKEW SYMMETRIC."
        End If
    End If
    Call matmul(tpos.matx, tpos.rows, tpos.cols, org.matx, org.rows, org.cols, t2.matx, t2.rows, t2.cols)
    If isunitmatrix(t2) Then
        l3.Caption = l3.Caption + "The Matrix is ORTHOGONAL."
    End If
    If rat_neq0(rat_stg(det)) Then
        l3.Caption = l3.Caption + "The Matrix is NON SINGULAR."
    Else
        l3.Caption = l3.Caption + "The Matrix is SINGULAR."
    End If
    If matrixequaltoconst(org, "0") Then
        l3.Caption = l3.Caption + "The Matrix is a ZERO Matrix."
    End If
    If isunitmatrix(org) Then
        l3.Caption = l3.Caption + "The Matrix is a UNIT MATRIX."
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

Private Sub iotm_Click()
On Error GoTo xit
    tmp_rat = det
    tmp2_matx = inv
    tmp1_matx = org
    r.hold = 6
    r.flg = 1
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub mexit_Click()
    Unload Me
End Sub

Private Sub motm_Click()
On Error GoTo xit
    tmp2_matx = t3
    tmp1_matx = org
    r.hold = 6
    r.flg = 6
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub rcfotm_Click()
On Error GoTo xit
    tmp2_matx = rcm
    tmp1_matx = org
    r.hold = 6
    r.flg = 3
    r.Show vbModal, Me
   'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub tmatx_Click()
On Error GoTo xit
    tmp2_matx = org
    tmp1_matx = org
    r.hold = 6
    r.flg = 0
    r.Show vbModal, Me
'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub totm_Click()
On Error GoTo xit
    tmp2_matx = tpos
    tmp1_matx = org
    r.hold = 6
    r.flg = 4
    r.Show vbModal, Me
    'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub
