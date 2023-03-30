VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Begin VB.Form lpp_bbm 
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000004&
   Caption         =   "Simplex Method"
   ClientHeight    =   6840
   ClientLeft      =   255
   ClientTop       =   1035
   ClientWidth     =   11850
   FillStyle       =   0  'Solid
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   9.75
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   FontTransparent =   0   'False
   HelpContextID   =   7
   Icon            =   "lpp_bbm.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cprev 
      BackColor       =   &H80000004&
      Caption         =   "&Previous Step"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   6720
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "Reloads previous state"
      Top             =   6630
      Width           =   1665
   End
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   10080
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   13
      ToolTipText     =   "Exit problem"
      Top             =   6630
      Width           =   1680
   End
   Begin VB.CommandButton cprob 
      BackColor       =   &H80000004&
      Caption         =   "Pr&oblem"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   105
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   8
      ToolTipText     =   "It will show you the current Lpp."
      Top             =   6630
      Width           =   1650
   End
   Begin VB.Frame fresult 
      BackColor       =   &H80000004&
      Caption         =   "Solution"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1335
      Left            =   120
      TabIndex        =   0
      ToolTipText     =   "Solution will be displayed here."
      Top             =   240
      Width           =   3135
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gresult 
         Height          =   975
         Left            =   120
         TabIndex        =   1
         ToolTipText     =   "Solution will be displayed here."
         Top             =   240
         Width           =   2895
         _ExtentX        =   5106
         _ExtentY        =   1720
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorSel    =   -2147483644
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
   Begin VB.CommandButton reduce 
      BackColor       =   &H80000004&
      Caption         =   "Pivot To &Unity"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   3420
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   10
      ToolTipText     =   "It will reduce the pivot to unity. ie Entering of a new variable to basis and leaving of an existing variable from basis."
      Top             =   6630
      Width           =   1650
   End
   Begin VB.CommandButton reset 
      BackColor       =   &H80000004&
      Caption         =   "&Reset"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   8385
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   12
      ToolTipText     =   "It will reload the initial simplex matrix."
      Top             =   6630
      Width           =   1680
   End
   Begin VB.CommandButton solve 
      BackColor       =   &H80000004&
      Caption         =   "&Solution"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   5070
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   11
      ToolTipText     =   "Will solve the problem directly. No steps will be shown."
      Top             =   6630
      Width           =   1650
   End
   Begin VB.CommandButton step 
      BackColor       =   &H80000004&
      Caption         =   "Next &Iteration"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   1770
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   9
      ToolTipText     =   "It will find the next PIVOTAL element or generate a new Constraint in Pure integer or Mixed integer programming."
      Top             =   6630
      Width           =   1650
   End
   Begin VB.Frame fup 
      BackColor       =   &H80000004&
      Caption         =   "Objective Function"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1335
      Left            =   3480
      TabIndex        =   2
      ToolTipText     =   "Objective function variables allong with their costs. Also include slack+surplus variables."
      Top             =   240
      Width           =   8295
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gup 
         Height          =   975
         Left            =   120
         TabIndex        =   3
         ToolTipText     =   "Objective function variables allong with their costs. Also include slack+surplus variables."
         Top             =   240
         Width           =   8055
         _ExtentX        =   14208
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
   Begin VB.Frame fmid 
      BackColor       =   &H80000004&
      Caption         =   "Simplex Table For Constraints"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   4455
      Left            =   3480
      TabIndex        =   6
      ToolTipText     =   "Simplex table."
      Top             =   1800
      Width           =   8295
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gmid 
         Height          =   4095
         Left            =   120
         TabIndex        =   7
         ToolTipText     =   "Simplex table."
         Top             =   240
         Width           =   8055
         _ExtentX        =   14208
         _ExtentY        =   7223
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   16777215
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
      Caption         =   "Simplex Base"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   4455
      Left            =   120
      TabIndex        =   4
      ToolTipText     =   "Base of Simplex table, containing variables in the basis and thier costs."
      Top             =   1800
      Width           =   3255
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gleft 
         Height          =   4095
         Left            =   120
         TabIndex        =   5
         ToolTipText     =   "Base of Simplex table, containing variables in the basis and thier costs."
         Top             =   240
         Width           =   3015
         _ExtentX        =   5318
         _ExtentY        =   7223
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
End
Attribute VB_Name = "lpp_bbm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim prblm As String
Dim piv As pivot
Public type_solve As String
Public pid As Long
Dim fprev As Long
Public sol As String

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

If type_solve = "BBM" Then
    tfprev = fprev - 1
    Call Form_load
    Do While fprev < tfprev
        Call step_Click 'piv = simplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, -1)
        If piv.xist And fprev < tfprev Then
            Call reduce_Click 'Call simplex_reduce_tounity(gleft, gmid, gup, piv)
        End If
    Loop
    If fprev = 0 Then cprev.Enabled = False
End If
Exit Sub
End Sub

Private Sub cprob_Click()
On Error GoTo xit
MsgBox prblm, vbOKOnly, "PROBLEM DEFINITION!!!"

Exit Sub
xit:
    Call error_me(Me)
End Sub

Public Sub Form_load()
On Error GoTo xit

    Step.Enabled = True
    reduce.Enabled = False
    gmid.Clear
    gup.Clear
    gleft.Clear
    gresult.Clear
    cprev.Visible = True
If type_solve = "BBM" Then
    fprev = 0
    Call simplex_make_matrix(pid, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    Call simplex_load_tables(gup, gmid, gleft, vars, cons, lpp_max, lpp_matrix(), lpp_rows, lpp_cols, lpp_obj(), lpp_penalty(), lpp_base(), lpp_bases, tots)
    cprev.Enabled = False
    prblm = get_problem
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub



Private Sub reduce_Click()
On Error GoTo xit
If type_solve = "BBM" Then
    fprev = fprev + 1
    Call simplex_reduce_tounity(gleft, gmid, gup, piv)
    reduce.Enabled = False
    Step.Enabled = True
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

Public Function lppform_bbm_solver() As Boolean
On Error GoTo xit
Dim stat As Integer
    
    Call Form_load
    stat = 2
    Do While stat <> 0 And stat <> 1
        piv = simplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, stat)
        If piv.xist Then
            Call simplex_reduce_tounity(gleft, gmid, gup, piv)
        End If
    Loop
    If stat = 0 Then
        lppform_bbm_solver = True
    Else
        lppform_bbm_solver = False
    End If
    
Exit Function
xit:
    Call error_me(Me)
End Function

Private Sub solve_Click()
On Error GoTo xit
Dim j As Integer

If type_solve = "BBM" Then
    
    Call Form_load
    piv.xist = True
    Call SendKeys("{ESC}")
    Do While piv.xist = True
        Call step_Click 'piv = simplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, -1)
        If piv.xist Then
            Call reduce_Click 'Call simplex_reduce_tounity(gleft, gmid, gup, piv)
        End If
    Loop
    If Trim(gresult.TextMatrix(0, 1)) = "" Then
        sol = vbCrLf & Space(10) & "NO SOLUTION BY METHOD CALLED " & type_solve
    Else
        sol = ""
        For j = 1 To gresult.cols - 1 Step 1
            sol = sol & vbCrLf & Space(10) & Trim(gresult.TextMatrix(0, j)) & "=" & Trim(gresult.TextMatrix(1, j))
        Next j
    End If
    
    MsgBox vbCrLf + "*****Problem Definition*****" + vbCrLf + prblm + vbCrLf + "-----Solution-----" + vbCrLf + sol
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub step_Click()
On Error GoTo xit
Dim succflg As Boolean

If type_solve = "BBM" Then
    piv = simplex_reload_tables(gup, gmid, gleft, gresult, vars, lpp_max, -1)
    If piv.xist Then
       fprev = fprev + 1
       Step.Enabled = False
       reduce.Enabled = True
       cprev.Enabled = True
    End If
End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Function get_problem() As String
On Error GoTo xit
Dim Y As New Recordset
Dim y1 As New Recordset
Dim i As Integer
Dim tvar As Integer
Dim tcon As Integer
Dim pb As String
Dim lpp_id As Long


        lpp_id = pid
        pb = vbCrLf
        Call connect
        Set Y = dn.cn.Execute("select n,m from lpp_main where pid=" & lpp_id & "")
        tvar = Val(Y.Fields("n"))
        tcon = Val(Y.Fields("m"))
        lpp_varint.vars = tvar
        ReDim lpp_varint.isint(lpp_varint.vars) As Boolean
        For i = 1 To lpp_varint.vars Step 1
            lpp_varint.isint(i) = True
        Next i
        Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & lpp_id & " and coid=0)")
        pb = pb & IIf(Y.Fields("e_type") = "MA", "MAX(Z)=", "MIN(Z)=")
        Set Y = dn.cn.Execute("select v_value from lpp_sub2 where(pid=" & lpp_id & " and coid=0) order by v_order")
        Y.MoveFirst
        For i = 1 To tvar Step 1
            pb = pb & IIf(i = 1, "", IIf(Val(Y.Fields("V_VALUE")) >= 0, "+", "")) & real_rat(Val(Y.Fields("v_value"))) & "X" & Trim(str(i))
            Y.MoveNext
        Next i
        pb = pb & vbCrLf & vbCrLf & "CONSTRAINTS:" & vbCrLf & vbCrLf
        Set Y = dn.cn.Execute("select coid,e_type from lpp_sub1 where(pid=" & lpp_id & " and coid<>0) order by coid")
        Y.MoveFirst
        While Not Y.EOF
            Set y1 = dn.cn.Execute("select v_value,v_order from lpp_sub2 where(pid=" & lpp_id & " and coid=" & Y.Fields("coid") & ") order by v_order")
            y1.MoveFirst
            i = 1
            While Not y1.EOF
                If Val(y1.Fields("V_order")) > tvar Then
                    pb = pb & IIf(Y.Fields("e_type") = "LE", "<=", IIf(Y.Fields("e_type") = "GE", ">=", "=")) & real_rat(Val(y1.Fields("v_value")))
                Else
                    pb = pb & IIf(i = 1, IIf(Val(y1.Fields("V_VALUE")) >= 0, " ", ""), IIf(y1.Fields("V_VALUE") >= 0, "+", "")) & real_rat(Val(y1.Fields("v_value"))) & "X" & Trim(str(Val(y1.Fields("v_order"))))
                    i = 2
                End If
                y1.MoveNext
              
            Wend
        pb = pb & vbCrLf
        Y.MoveNext
        Wend
        
        pb = pb & vbCrLf
        For i = 1 To tvar Step 1
            pb = pb & IIf(i = 1, "", ",") & "X" & Trim(str(i)) & ">=0"
        Next i
        
        pb = pb & vbCrLf & vbCrLf
        
        For i = 1 To lpp_varint.vars Step 1
            If lpp_varint.isint(i) Then
                pb = pb & "X" & Trim(str(i)) & " IS INTEGER." & vbCrLf
            End If
        Next i
        
get_problem = pb

Exit Function
xit:
    get_problem = "ERROR"
    Call error_me(Me)
End Function

