VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Begin VB.Form lpp_solve 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "LPP solver"
   ClientHeight    =   7485
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11850
   HelpContextID   =   6
   Icon            =   "lpp_solve.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8625
   ScaleWidth      =   11910
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.CommandButton step 
      BackColor       =   &H80000004&
      Caption         =   "Next &Iteration"
      Height          =   495
      Left            =   1740
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   24
      ToolTipText     =   "It will find the next PIVOTAL element or generate a new Constraint in Pure integer or Mixed integer programming."
      Top             =   7575
      Width           =   1620
   End
   Begin VB.CommandButton solve 
      BackColor       =   &H80000004&
      Caption         =   "&Solution"
      Height          =   495
      Left            =   5010
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   23
      ToolTipText     =   "Will solve the problem directly. No steps will be shown."
      Top             =   7575
      Width           =   1635
   End
   Begin VB.CommandButton reset 
      BackColor       =   &H80000004&
      Caption         =   "&Reset"
      Height          =   495
      Left            =   8460
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   22
      ToolTipText     =   "It will reload the initial simplex matrix."
      Top             =   7575
      Width           =   1710
   End
   Begin VB.CommandButton reduce 
      BackColor       =   &H80000004&
      Caption         =   "Pivot To &Unity"
      Height          =   495
      Left            =   3375
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   21
      ToolTipText     =   "It will reduce the pivot to unity. ie Entering of a new variable to basis and leaving of an existing variable from basis."
      Top             =   7575
      Width           =   1620
   End
   Begin VB.CommandButton cprob 
      BackColor       =   &H80000004&
      Caption         =   "Pr&oblem"
      Height          =   495
      Left            =   105
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   20
      ToolTipText     =   "It will show you the current Lpp."
      Top             =   7575
      Width           =   1620
   End
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      Height          =   495
      Left            =   10185
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   19
      ToolTipText     =   "Exit to main menu"
      Top             =   7575
      Width           =   1695
   End
   Begin VB.CommandButton cprev 
      BackColor       =   &H80000004&
      Caption         =   "&Previous Step"
      Height          =   495
      Left            =   6660
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   18
      ToolTipText     =   "Reloads the previous state"
      Top             =   7575
      Width           =   1650
   End
   Begin VB.Frame frstd 
      BackColor       =   &H80000004&
      Caption         =   "Specify Unrestricted Variables"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   3930
      Left            =   2498
      TabIndex        =   12
      ToolTipText     =   "Unrestricted variables in Dual finding."
      Top             =   2430
      Width           =   6855
      Begin VB.ListBox rstdlist 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000002&
         Height          =   3030
         Left            =   120
         Sorted          =   -1  'True
         Style           =   1  'Checkbox
         TabIndex        =   13
         ToolTipText     =   "Contains unrestricted variables."
         Top             =   240
         Width           =   6615
      End
      Begin VB.CommandButton rstdshow 
         BackColor       =   &H80000004&
         Caption         =   "&Show Dual"
         Height          =   495
         Left            =   3375
         Style           =   1  'Graphical
         TabIndex        =   16
         ToolTipText     =   "It will show you the dual of the current problem."
         Top             =   3315
         Width           =   1695
      End
      Begin VB.CommandButton rstdprblm 
         BackColor       =   &H80000004&
         Caption         =   "&Problem"
         Height          =   495
         Left            =   1695
         Style           =   1  'Graphical
         TabIndex        =   15
         ToolTipText     =   "Show you the current problem with the specified unrestricted variables."
         Top             =   3315
         Width           =   1665
      End
      Begin VB.CommandButton rstdok 
         BackColor       =   &H80000004&
         Caption         =   "&Accept"
         Height          =   495
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   14
         ToolTipText     =   "I selected all unrestricted variables."
         Top             =   3315
         Width           =   1560
      End
      Begin VB.CommandButton rstdnotok 
         BackColor       =   &H80000004&
         Caption         =   "&Cancel"
         Height          =   495
         Left            =   5085
         Style           =   1  'Graphical
         TabIndex        =   17
         ToolTipText     =   "Deselects all selected variables."
         Top             =   3315
         Width           =   1650
      End
   End
   Begin VB.Frame fint 
      BackColor       =   &H80000004&
      Caption         =   "Specify Integer Variables"
      ForeColor       =   &H80000008&
      Height          =   1695
      Left            =   120
      TabIndex        =   2
      ToolTipText     =   "Specify Integer Variables."
      Top             =   120
      Width           =   3255
      Begin VB.CommandButton intnotok 
         BackColor       =   &H80000004&
         Caption         =   "&Cancel"
         Height          =   405
         Left            =   1920
         Style           =   1  'Graphical
         TabIndex        =   5
         ToolTipText     =   "Deselect all variables."
         Top             =   1245
         Width           =   1215
      End
      Begin VB.CommandButton intok 
         BackColor       =   &H80000004&
         Caption         =   "&Ok"
         Height          =   405
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   4
         ToolTipText     =   "Specification of integer variables completed.  "
         Top             =   1230
         Width           =   1215
      End
      Begin VB.ListBox intlist 
         ForeColor       =   &H80000002&
         Height          =   960
         Left            =   120
         Sorted          =   -1  'True
         Style           =   1  'Checkbox
         TabIndex        =   3
         ToolTipText     =   "Select Integer variables from this list."
         Top             =   240
         Width           =   3015
      End
   End
   Begin VB.Frame fresult 
      BackColor       =   &H80000004&
      Caption         =   "Solution"
      ForeColor       =   &H80000008&
      Height          =   1335
      Left            =   120
      TabIndex        =   0
      ToolTipText     =   "Solution will be displayed here."
      Top             =   240
      Width           =   3255
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gresult 
         Height          =   975
         Left            =   120
         TabIndex        =   1
         ToolTipText     =   "Solution will be displayed here."
         Top             =   240
         Width           =   3015
         _ExtentX        =   5318
         _ExtentY        =   1720
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   16777215
         GridLines       =   3
         BorderStyle     =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
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
   End
   Begin VB.Frame fup 
      BackColor       =   &H80000004&
      Caption         =   "Objective Function"
      ForeColor       =   &H80000008&
      Height          =   1335
      Left            =   3480
      TabIndex        =   6
      ToolTipText     =   "Objective function variables allong with their costs. Also include slack+surplus variables."
      Top             =   240
      Width           =   8385
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gup 
         Height          =   975
         Left            =   120
         TabIndex        =   7
         ToolTipText     =   "Objective function variables allong with their costs. Also include slack+surplus variables."
         Top             =   240
         Width           =   8205
         _ExtentX        =   14473
         _ExtentY        =   1720
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   16777215
         GridLines       =   3
         BorderStyle     =   0
         GridLineWidth   =   10
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
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
         _Band(0).GridLineWidthBand=   10
         _Band(0).TextStyleBand=   0
      End
   End
   Begin VB.Frame fmid 
      BackColor       =   &H80000004&
      Caption         =   "Simplex Table For Constraints"
      ForeColor       =   &H80000008&
      Height          =   5265
      Left            =   3480
      TabIndex        =   10
      ToolTipText     =   "Simplex table."
      Top             =   1800
      Width           =   8385
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gmid 
         Height          =   4950
         Left            =   120
         TabIndex        =   11
         ToolTipText     =   "Simplex table."
         Top             =   240
         Width           =   8190
         _ExtentX        =   14446
         _ExtentY        =   8731
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   16777215
         GridColorUnpopulated=   16777215
         GridLines       =   3
         BorderStyle     =   0
         RowSizingMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
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
   End
   Begin VB.Frame fleft 
      BackColor       =   &H80000004&
      Caption         =   "Simplex base"
      ForeColor       =   &H80000008&
      Height          =   5280
      Left            =   120
      TabIndex        =   8
      ToolTipText     =   "Base of Simplex table, containing variables in the basis and thier costs."
      Top             =   1800
      Width           =   3255
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gleft 
         Height          =   4935
         Left            =   120
         TabIndex        =   9
         ToolTipText     =   "Base of Simplex table, containing variables in the basis and thier costs."
         Top             =   240
         Width           =   3015
         _ExtentX        =   5318
         _ExtentY        =   8705
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   16777215
         GridLines       =   3
         BorderStyle     =   0
         GridLineWidth   =   10
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
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
         _Band(0).GridLineWidthBand=   10
         _Band(0).TextStyleBand=   0
      End
   End
End
Attribute VB_Name = "lpp_solve"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim lppint As lpp_ints
Public duals As String
Public prblm As String
Public sol As String
Dim opt As Integer
Dim piv As pivot
Public hold As Long
Public type_solve As String
Public pid As Long
Public gomery_opt As Integer
Dim fprev As Long
Dim show_flg As Boolean

Dim vars As Integer
Dim cons As Integer
Dim lpp_max As Boolean
Dim lpp_matrix() As Double
Dim lpp_rows As Long
Dim lpp_cols As Long
Dim lpp_obj() As Double
Dim lpp_penalty() As Boolean
Dim lpp_base() As Double
Dim lpp_bases As Long
Dim tots As Long



Private Sub cexit_Click()
        Unload Me
End Sub

Private Sub cprev_Click()
Dim tfprev As Long

tfprev = fprev - 1
If type_solve = "SOLVE_SIMPLEX" Or type_solve = "SOLVE_DSIMPLEX" Then
    Call Form_load
    Do While fprev < tfprev
        If step.Enabled Then
            Call step_Click
        ElseIf reduce.Enabled Then
            Call reduce_Click
        End If
    Loop
    If fprev = 0 Then cprev.Enabled = False
End If

If type_solve = "SOLVE_MIXED" Or type_solve = "SOLVE_GOMERY" Then
    gomery_opt = 0
    Call simplex_make_matrix(pid, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    gmid.clear
    gup.clear
    gleft.clear
    Call simplex_load_tables(gup, gmid, gleft, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    step.Enabled = True
    reduce.Enabled = False
    cprev.Enabled = False
    fprev = 0
    show_flg = False
    Do While fprev < tfprev
        If step.Enabled Then
            Call step_Click
        ElseIf reduce.Enabled Then
            Call reduce_Click
        End If
    Loop
    show_flg = True
    If fprev = 0 Then cprev.Enabled = False
End If

End Sub

Private Sub cprob_Click()
MsgBox prblm, vbOKOnly, "PROBLEM DEFINITION!!!"
End Sub


Public Sub Form_load()
On Error GoTo xit
Dim Y As New Recordset
Dim i As Integer

    step.Enabled = True
    reduce.Enabled = False
    fint.Visible = False
    frstd.Visible = False
    gmid.clear
    gup.clear
    gleft.clear
    gresult.clear
    fprev = 0
    show_flg = True
    cprev.Enabled = False
    
Call connect
Set Y = dn.cn.Execute("select n from lpp_main where pid=" & pid)
lpp_varint.vars = Y.Fields("n")
lppint.vars = Y.Fields("n") - 1
If type_solve = "DUAL" Then
    For i = 0 To Me.Count - 1 Step 1
        Me.Controls(i).Visible = False
    Next i
    frstd.Visible = True
    rstdlist.Visible = True
    rstdok.Visible = True
    rstdnotok.Visible = True
    rstdprblm.Visible = True
    rstdshow.Visible = True
    rstdprblm.Enabled = False
    rstdshow.Enabled = False
    ReDim lppint.isint(lppint.vars) As Boolean
    For i = 0 To lppint.vars Step 1
        lppint.isint(i) = False
        rstdlist.AddItem "X" & Trim(str(i + 1)), i
    Next i
    cexit.Visible = True
    cexit.Enabled = True
Exit Sub
End If

ReDim lpp_varint.isint(lpp_varint.vars) As Boolean
For i = 1 To lpp_varint.vars Step 1
    lpp_varint.isint(i) = False
Next i

If type_solve = "SOLVE_MIXED" Then
    fprev = 0
    cprev.Enabled = False
    cprev.Visible = False
    gomery_opt = 0
    cprob.Enabled = False
    step.Enabled = False
    solve.Enabled = False
    reduce.Enabled = False
    cprev.Visible = True
    cprev.Enabled = False
    Y.MoveFirst
    intlist.clear
    For i = 1 To Y.Fields("n") Step 1
        intlist.AddItem "X" & Trim(str(i)), i - 1
    Next i
    fint.Visible = True
End If

If type_solve = "SOLVE_SIMPLEX" Or type_solve = "SOLVE_GOMERY" Then
    fprev = 0
    cprev.Enabled = False
    If type_solve = "SOLVE_GOMERY" Then
        Y.MoveFirst
        For i = 1 To lpp_varint.vars Step 1
            lpp_varint.isint(i) = True
        Next i
        gomery_opt = 0
    End If
End If

If type_solve <> "SOLVE_MIXED" Then
    prblm = get_problem
    cprev.Enabled = False
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_Unload(cancel As Integer)
On Error GoTo xit

    If hold = 0 Then
        or_form1.Show
    ElseIf hold = 1 Then
        foptions.Show
    ElseIf hold = 2 Then
        'nothing since used find problem only from r.frm
    End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub intnotok_Click()
On Error GoTo xit
Dim i As Integer

For i = 0 To intlist.ListCount - 1 Step 1
    intlist.Selected(i) = False
Next i
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub intok_Click()
On Error GoTo xit
Dim i As Integer

For i = 0 To intlist.ListCount - 1 Step 1
    If intlist.Selected(i) Then
        lpp_varint.isint(i + 1) = True
    Else
        lpp_varint.isint(i + 1) = False
    End If
Next i
prblm = get_problem
fint.Visible = False
step.Enabled = True
solve.Enabled = True
reduce.Enabled = False
cprob.Enabled = True
cprev.Visible = True
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub reduce_Click()
On Error GoTo xit
If type_solve = "SOLVE_SIMPLEX" Then
    fprev = fprev + 1
    Call simplex_reduce_tounity(gleft, gmid, gup, piv)
    reduce.Enabled = False
    step.Enabled = True
End If

If type_solve = "SOLVE_DSIMPLEX" Then
    fprev = fprev + 1
    Call dualsimplex_reduce_tounity(gleft, gmid, gup, piv)
    reduce.Enabled = False
    step.Enabled = True
End If

If type_solve = "SOLVE_GOMERY" Or type_solve = "SOLVE_MIXED" Then
    If gomery_opt = 0 Then
        If opt = 2 Then
            fprev = fprev + 1
            Call simplex_reduce_tounity(gleft, gmid, gup, piv)
        End If
    Else
        If gomery_opt = 2 Then
            If opt = 2 Then
                fprev = fprev + 1
                Call dualsimplex_reduce_tounity(gleft, gmid, gup, piv)
            End If
        End If
    End If
reduce.Enabled = False
step.Enabled = True
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub reset_Click()
On Error GoTo xit
     Call Form_load
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub rstdlist_Click()
On Error GoTo xit
    rstdprblm.Enabled = False
    rstdshow.Enabled = False
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub rstdnotok_Click()
On Error GoTo xit
Dim i As Integer

rstdprblm.Enabled = False
rstdshow.Enabled = False
For i = 0 To rstdlist.ListCount - 1 Step 1
    rstdlist.Selected(i) = False
Next i
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub rstdok_Click()
On Error GoTo xit
Dim i As Integer

For i = 0 To rstdlist.ListCount - 1 Step 1
    If rstdlist.Selected(i) Then
        lppint.isint(i) = True
    Else
        lppint.isint(i) = False
    End If
Next i
prblm = get_problem
rstdprblm.Enabled = True
rstdshow.Enabled = True
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub rstdprblm_Click()
    MsgBox prblm, vbOKOnly, "PRIMAL DEFINITION"
End Sub

Private Sub rstdshow_Click()
On Error GoTo xit
Dim x As std_lpp

    x = make_stdlpp(pid, lppint)
    duals = make_dual(x)
        r.hold = 1
        r.flg = 1
        r.Caption = "LINEAR PROGRAMMING PROBLEM DEFINITION"
        r.Show vbModal, Me
        'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub solve_Click()
On Error GoTo xit
Dim j As Integer

If type_solve = "SOLVE_SIMPLEX" Then
    Call Form_load
    piv.xist = True
    Do While piv.xist = True
        piv = simplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, -1)
        If piv.xist Then
            fprev = fprev + 2
            Call simplex_reduce_tounity(gleft, gmid, gup, piv)
        End If
    Loop
    If fprev > 0 Then cprev.Enabled = True
End If

If type_solve = "SOLVE_DSIMPLEX" Then
    Call Form_load
    piv.xist = True
    Do While piv.xist = True
        piv = dualsimplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, -1)
        If piv.xist Then
            fprev = fprev + 2
            Call dualsimplex_reduce_tounity(gleft, gmid, gup, piv)
        End If
    Loop
    If fprev > 0 Then cprev.Enabled = True
End If

If type_solve = "SOLVE_MIXED" Then
    gomery_opt = 0
    fprev = 0
    Call simplex_make_matrix(pid, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    gmid.clear
    gup.clear
    gleft.clear
    Call simplex_load_tables(gup, gmid, gleft, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    cprev.Enabled = False
    Do While gomery_opt >= 0 And gomery_opt <= 2
        Call pure_gomery_method(True, gup, gmid, gleft, gresult, gomery_opt, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots, fprev, pid)
    Loop
    If fprev > 0 Then cprev.Enabled = True
End If

If type_solve = "SOLVE_GOMERY" Then
    gomery_opt = 0
    fprev = 0
    Call simplex_make_matrix(pid, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    gmid.clear
    gup.clear
    gleft.clear
    Call simplex_load_tables(gup, gmid, gleft, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    cprev.Enabled = False
    Do While gomery_opt >= 0 And gomery_opt <= 2
        Call pure_gomery_method(False, gup, gmid, gleft, gresult, gomery_opt, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots, fprev, pid)
    Loop
    If fprev > 0 Then cprev.Enabled = True
End If

If Trim(gresult.TextMatrix(0, 1)) = "" Then
    sol = vbCrLf & Space(10) & "NO SOLUTION BY METHOD CALLED " & type_solve
Else
    sol = ""
    For j = 1 To gresult.cols - 1 Step 1
        sol = sol & vbCrLf & Space(10) & Trim(gresult.TextMatrix(0, j)) & "=" & Trim(gresult.TextMatrix(1, j))
    Next j
End If
        
        r.hold = 1
        r.flg = 0
        r.Caption = "LINEAR PROGRAMMING PROBLEM DEFINITION"
        r.Show vbModal, Me
        'me.hide
        
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub step_Click()
On Error GoTo xit
Dim succflg As Boolean

If type_solve = "SOLVE_SIMPLEX" Then
    piv = simplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, -1)
    If piv.xist Then
       fprev = fprev + 1
       cprev.Enabled = True
       step.Enabled = False
       reduce.Enabled = True
    End If
End If
If type_solve = "SOLVE_DSIMPLEX" Then
    piv = dualsimplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, -1)
    If piv.xist Then
       fprev = fprev + 1
       cprev.Enabled = True
       step.Enabled = False
       reduce.Enabled = True
    End If
End If


If type_solve = "SOLVE_GOMERY" Or type_solve = "SOLVE_MIXED" Then
    
    If gomery_opt = 4 Then
        If type_solve = "SOLVE_GOMERY" Then
            MsgBox "YOU ALREADY GOT AN INTEGER FEASIBLE SOLUTION"
        Else
            MsgBox "YOU ALREADY GOT AN MIXED-INTEGER FEASIBLE SOLUTION." & vbCrLf & "ALL SPECIFIED VARIABLES ARE INTEGERS."
        End If
        Exit Sub
    End If
    
    If gomery_opt = 3 Then
        MsgBox IIf(type_solve = "SOLVE_GOMERY", "GOMERY", "MIXED") & " METHOD FAILED!!!"
        Exit Sub
    End If
    
    If gomery_opt = 0 Then
        fprev = fprev + 1
        piv = simplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, opt)
        If opt = 0 Then
           gomery_opt = 1
        Else
            If opt = 1 Then
                MsgBox "SIMPLEX METHOD FAILED,TERMINATING"
                gomery_opt = 3
                Exit Sub
            Else
                cprev.Enabled = True
                step.Enabled = False
                reduce.Enabled = True
            End If
        End If
    Else
        If gomery_opt = 1 Then
            fprev = fprev + 1
            If type_solve = "SOLVE_GOMERY" Then
                succflg = gomery_method_sub(gup, gmid, gleft, gresult, show_flg)
            Else
                succflg = mixed_method_sub(gup, gmid, gleft, gresult, show_flg)
            End If
            
            If succflg Then
                gomery_opt = 4
                Exit Sub
            Else
                gomery_opt = 2
            End If
        Else
            If gomery_opt = 2 Then
                fprev = fprev + 1
                piv = dualsimplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, opt)
                If opt = 0 Then
                    gomery_opt = 1
                Else
                    If opt = 1 Then
                        MsgBox "DUALSIMPLEX METHOD FAILED,TERMINATING"
                        gomery_opt = 3
                        Exit Sub
                    Else
                        cprev.Enabled = True
                        step.Enabled = False
                        reduce.Enabled = True
                    End If
                End If
            End If
        End If
    End If
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Public Function get_problem(Optional pbar As ProgressBar) As String
On Error GoTo xit
Dim Y As New Recordset
Dim y1 As New Recordset
Dim i As Integer
Dim tvar As Integer
Dim tcon As Integer
Dim pb As String
Dim lpp_id As Long


If type_solve <> "DUAL" Then
    If type_solve = "SOLVE_DSIMPLEX" Then
        Call dualsimplex_make_matrix(pid, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
        Call dualsimplex_load_tables(gup, gmid, gleft, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    Else
        Call simplex_make_matrix(pid, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
        Call simplex_load_tables(gup, gmid, gleft, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    End If
End If

        
        lpp_id = pid
        pb = "              " & vbCrLf & vbCrLf
        Call connect
        Set Y = dn.cn.Execute("select n,m from lpp_main where pid=" & lpp_id & "")
        tvar = Val(Y.Fields("n"))
        tcon = Val(Y.Fields("m"))
        If Not pbar Is Nothing Then pbar.max = tcon * tvar
        Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & lpp_id & " and coid=0)")
        pb = pb & Space(10) & IIf(Y.Fields("e_type") = "MA", "MAX(Z)=", "MIN(Z)=")
        Set Y = dn.cn.Execute("select v_value from lpp_sub2 where(pid=" & lpp_id & " and coid=0) order by v_order")
        Y.MoveFirst
        For i = 1 To tvar Step 1
            pb = pb & IIf(i = 1, "", IIf(Val(Y.Fields("V_VALUE")) >= 0, "+", "")) & real_rat(Y.Fields("v_value")) & "X" & Trim(str(i))
            Y.MoveNext
        Next i
        If Not pbar Is Nothing Then pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
        pb = pb & vbCrLf & vbCrLf & Space(10) & "CONSTRAINTS:" & vbCrLf & vbCrLf
        Set Y = dn.cn.Execute("select coid,e_type from lpp_sub1 where(pid=" & lpp_id & " and coid<>0) order by coid")
        Y.MoveFirst
        While Not Y.EOF
            Set y1 = dn.cn.Execute("select v_value,v_order from lpp_sub2 where(pid=" & lpp_id & " and coid=" & Y.Fields("coid") & ") order by v_order")
            y1.MoveFirst
            i = 1
            pb = pb & Space(15)
            While Not y1.EOF
                If y1.Fields("V_order") > tvar Then
                    pb = pb & IIf(Y.Fields("e_type") = "LE", "<=", IIf(Y.Fields("e_type") = "GE", ">=", "=")) & real_rat(y1.Fields("v_value"))
                Else
                    pb = pb & IIf(i = 1, IIf(Val(y1.Fields("V_VALUE")) >= 0, " ", ""), IIf(y1.Fields("V_VALUE") >= 0, "+", "")) & real_rat(y1.Fields("v_value")) & "X" & Trim(str(y1.Fields("v_order")))
                    i = 2
                End If
                y1.MoveNext
                If Not pbar Is Nothing Then pbar.Value = IIf(pbar.Value < pbar.max, pbar.Value + 1, pbar.max)
            Wend
        pb = pb & vbCrLf
        Y.MoveNext
        Wend
        
        pb = pb & vbCrLf & Space(10)
        For i = 1 To tvar Step 1
            pb = pb & IIf(i = 1, "", ",") & "X" & Trim(str(i)) & ">=0"
        Next i
        
        pb = pb & vbCrLf & vbCrLf
        
        If type_solve <> "DUAL" Then
            For i = 1 To lpp_varint.vars Step 1
                If lpp_varint.isint(i) Then
                    pb = pb & Space(10) & "X" & Trim(str(i)) & " IS INTEGER." & vbCrLf
                End If
            Next i
        Else
            For i = 0 To lppint.vars Step 1
                If lppint.isint(i) Then
                    pb = pb & Space(10) & "X" & Trim(str(i + 1)) & " IS UNRESTRICTED." & vbCrLf
                End If
            Next i
        End If
        If Not pbar Is Nothing Then pbar.Value = pbar.max
        If Not pbar Is Nothing Then pbar.Visible = False
get_problem = pb

Exit Function
xit:
    Call error_me(Me)
End Function
