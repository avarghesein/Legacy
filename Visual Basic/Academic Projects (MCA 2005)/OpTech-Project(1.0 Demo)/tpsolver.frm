VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form tpsolver 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "TPP solver"
   ClientHeight    =   7185
   ClientLeft      =   45
   ClientTop       =   660
   ClientWidth     =   11145
   HelpContextID   =   8
   Icon            =   "tpsolver.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7185
   ScaleWidth      =   11145
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid m2 
      Height          =   375
      Left            =   8040
      TabIndex        =   11
      Top             =   7620
      Visible         =   0   'False
      Width           =   615
      _ExtentX        =   1085
      _ExtentY        =   661
      _Version        =   393216
      ForeColorFixed  =   -2147483624
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
   End
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      Height          =   495
      Left            =   10770
      Style           =   1  'Graphical
      TabIndex        =   10
      ToolTipText     =   "Exit to main menu"
      Top             =   7080
      WhatsThisHelpID =   8
      Width           =   1095
   End
   Begin VB.CommandButton cprev 
      BackColor       =   &H80000004&
      Caption         =   "&Previous Step"
      Height          =   495
      Left            =   5550
      Style           =   1  'Graphical
      TabIndex        =   9
      ToolTipText     =   "Reloads previous state"
      Top             =   7080
      WhatsThisHelpID =   8
      Width           =   1815
   End
   Begin VB.CommandButton c4 
      BackColor       =   &H80000004&
      Caption         =   "&Reset"
      Height          =   495
      Left            =   9675
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Reloads the initial TP matrix."
      Top             =   7080
      WhatsThisHelpID =   8
      Width           =   1095
   End
   Begin VB.CommandButton c3 
      BackColor       =   &H80000004&
      Caption         =   "Allocate On Circuit"
      Height          =   495
      Left            =   3735
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "It will allocate(add or subtract) the minimal allocated amount in the LOOP to and from the Transition cells of the LOOP."
      Top             =   7080
      WhatsThisHelpID =   8
      Width           =   1815
   End
   Begin VB.CommandButton c2 
      BackColor       =   &H80000004&
      Caption         =   "Allocate"
      Height          =   495
      Left            =   1920
      Style           =   1  'Graphical
      TabIndex        =   3
      ToolTipText     =   "It will allocate the Maximum feasible amout on the PIVOTAL element."
      Top             =   7080
      WhatsThisHelpID =   8
      Width           =   1815
   End
   Begin VB.CommandButton c1 
      BackColor       =   &H80000004&
      Caption         =   "Find Pivot"
      Height          =   495
      Left            =   105
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "finds->the next matrix element for allocating the Maximum Feasible amount,net evaluations,cells for Epsilon allocations."
      Top             =   7080
      WhatsThisHelpID =   8
      Width           =   1815
   End
   Begin VB.Frame freal 
      BackColor       =   &H80000004&
      Caption         =   "Transportation Table"
      ForeColor       =   &H00000000&
      Height          =   6870
      Left            =   120
      TabIndex        =   0
      ToolTipText     =   "Transportation Table(Transformed if Maximization problem)"
      Top             =   120
      WhatsThisHelpID =   8
      Width           =   11745
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid f1 
         Height          =   495
         Left            =   240
         TabIndex        =   8
         Top             =   1680
         Visible         =   0   'False
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   873
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   -2147483624
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
         _Band(0).TextStyleBand=   0
      End
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid f2 
         Height          =   735
         Left            =   3480
         TabIndex        =   7
         Top             =   1920
         Visible         =   0   'False
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   1296
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   -2147483624
         BorderStyle     =   0
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
         _Band(0).TextStyleBand=   0
      End
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid f3 
         Height          =   495
         Left            =   1800
         TabIndex        =   6
         Top             =   3000
         Visible         =   0   'False
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   873
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   -2147483624
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
         _Band(0).TextStyleBand=   0
      End
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid greal 
         Height          =   6525
         Left            =   120
         TabIndex        =   1
         ToolTipText     =   "Transportation Table(Transformed if Maximization problem)"
         Top             =   270
         Width           =   11550
         _ExtentX        =   20373
         _ExtentY        =   11509
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridColorFixed  =   -2147483624
         GridLines       =   3
         BorderStyle     =   0
         RowSizingMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BeginProperty FontFixed {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   11.25
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
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid m1 
      Height          =   375
      Left            =   7800
      TabIndex        =   12
      Top             =   7320
      Visible         =   0   'False
      Width           =   615
      _ExtentX        =   1085
      _ExtentY        =   661
      _Version        =   393216
      ForeColorFixed  =   -2147483624
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
   End
   Begin MSHierarchicalFlexGridLib.MSHFlexGrid m3 
      Height          =   375
      Left            =   8040
      TabIndex        =   13
      Top             =   7710
      Visible         =   0   'False
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   661
      _Version        =   393216
      ForeColorFixed  =   -2147483624
      _NumberOfBands  =   1
      _Band(0).Cols   =   2
   End
   Begin ComctlLib.StatusBar ssbar 
      Align           =   2  'Align Bottom
      Height          =   345
      Left            =   0
      TabIndex        =   14
      Top             =   6840
      Width           =   11145
      _ExtentX        =   19659
      _ExtentY        =   609
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   2
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Menu opts 
      Caption         =   "&View"
      Begin VB.Menu prblm 
         Caption         =   "Problem"
         Shortcut        =   ^P
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu solution 
         Caption         =   "Solution"
         Shortcut        =   ^S
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu mexit 
         Caption         =   "Exit"
         Shortcut        =   ^E
      End
   End
End
Attribute VB_Name = "tpsolver"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim flg As Integer
Public hold As Long
Public method As String
Public metid As Long
Dim pi As tpivot
Dim e As element
Dim cflg As Long
Dim v As vector
Dim max As Boolean
Dim gridflg As Boolean

Private Sub c1_Click()
On Error GoTo xit
Dim i As Integer
Dim j As Integer

If flg = 6 Then
    MsgBox "ERROR E-ALLOCATIONS CANNOT BE MADE!!!", vbOKOnly, "ERROR!!!"
    Exit Sub
End If
If flg = 8 Then
     If MsgBox("DO YOU WANT TO SEE THE OPTIMAL SOLUTION DETAILS?", vbYesNo, "YOU ALREADY GOT A OPTIMUM SOLUTION!!!") = vbYes Then
        r.hold = 0
        r.maxp = max
        r.flg = 1
        r.Caption = "TRANSPORTATION PROBLEM DEFINITION"
        r.Show vbModal, Me
        'me.hide
     End If
     Exit Sub
End If

If flg = 0 Then
    Select Case method
        Case "VAM":
                    pi = vam_method_part1(f1, f2)
        Case "MMM":
                    pi = mat_min_method(f1, f2)
        Case "NWCR":
                    pi = nwcr_method(f1, f2)
    End Select
    If Not pi.xist Then
        If all_allocated(f2) Then
            c1.Caption = "&Net Evaluations"
            c1.ToolTipText = "Finds net evaluations for non allocated cells"
            flg = 3
        Else
            c1.Caption = "&E-allocation"
            c1.ToolTipText = "To make total_allocation=m+n-1"
            flg = 2
        End If
        c2.Caption = "Find &Circuit"
        c2.ToolTipText = "Finds a Loop or Circuit"
        If method = "VAM" Then
            f2.rows = f2.rows - 1
            f2.cols = f2.cols - 1
        End If
        f3.rows = f2.rows
        f3.cols = f2.cols
        Call copy_head(f2, f3)
        cflg = cflg + 1
        cprev.Enabled = True
        Exit Sub
    Else
        c1.Enabled = False
        c2.Enabled = True
        flg = 1
        Call real_process
        cflg = cflg + 1
        cprev.Enabled = True
    End If
Else
    If flg = 2 Then
        i = make_allocation(f1, f2)
        If i = 1 Then
            flg = 6
            cflg = cflg + 1
            Call c1_Click
            Exit Sub
        Else
            If i = 0 Then
                c1.Caption = "&Net Evaluations"
                c1.ToolTipText = "Finds net evaluations for non allocated cells"
                flg = 3
                cflg = cflg + 1
                Exit Sub
            Else
                If all_allocated(f2) Then
                    c1.Caption = "&Net Evaluations"
                    c1.ToolTipText = "Finds net evaluations for non allocated cells"
                    Call real_process
                    flg = 3
                    cflg = cflg + 1
                    Exit Sub
                Else
                    flg = 2
                    cflg = cflg + 1
                End If
                Call real_process
                Exit Sub
            End If
        End If
    Else
        If flg = 3 Then
            greal.GridLines = flexGridFlat
            For i = 1 To f2.rows - 1 Step 1
                For j = 1 To f2.cols - 1 Step 1
                    f2.row = i
                    f2.col = j
                    f2.CellBackColor = RGB(300, 300, 300)
                Next j
            Next i
            Call cal_uivj(f1, f2, f3)
            pi = findnet(f3, f1, f2)
            Call real_process
            If pi.xist Then
                flg = 4
                c2.Enabled = True
                c1.Enabled = False
                cflg = cflg + 1
             Else
                 flg = 8
                 cflg = cflg + 1
                 Call c1_Click
                 Exit Sub
           End If
        End If
    End If
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub c2_Click()
On Error GoTo xit
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim l As Integer
Dim max As Integer
Dim tpiv As tpivot

If flg = 7 Then
    If MsgBox("CIRCUIT CANNOT BE FOUND!!!,DO YOU WANT TO SEE THE OBTAINED SOLUTION DETAILS?", vbYesNo, "ERROR!!!") = vbYes Then
            r.hold = 0
            r.flg = 2
            r.maxp = max
            r.Caption = "TRANSPORTATION PROBLEM DEFINITION"
            r.Show vbModal, Me
            'me.hide
    End If
    Exit Sub
End If

If flg = 1 Then
    Select Case method
        Case "VAM":
                    Call vam_method_part2(pi, f1, f2)
        Case "MMM":
                    Call nwcr_method_part2(pi, f1, f2)
        Case "NWCR":
                    Call nwcr_method_part2(pi, f1, f2)
    End Select
    c2.Enabled = False
    c1.Enabled = True
    cflg = cflg + 1
    
    Call copy_grid1togrid2(f1, m1, True, False)
    Call copy_grid1togrid2(f2, m2, True, False)
    Select Case method
        Case "VAM":
                    tpiv = vam_method_part1(m1, m2)
        Case "MMM":
                    tpiv = mat_min_method(m1, m2)
        Case "NWCR":
                    tpiv = nwcr_method(m1, m2)
    End Select
    If tpiv.xist Then
        flg = 0
    Else
        Call real_process
        If all_allocated(m2) Then
            c1.Caption = "&Net Evaluations"
            c1.ToolTipText = "Finds net evaluations for non allocated cells"
            flg = 3
        Else
            c1.Caption = "&E-allocation"
            c1.ToolTipText = "To make total_allocation=m+n-1"
            flg = 2
        End If
        c2.Caption = "Find &Circuit"
        c2.ToolTipText = "Finds a Loop or Circuit"
        If method = "VAM" Then
            f2.rows = f2.rows - 1
            f2.cols = f2.cols - 1
        End If
        f3.rows = f2.rows
        f3.cols = f2.cols
        Call copy_head(f2, f3)
        cprev.Enabled = True
        Exit Sub
    End If
Else
    If flg = 4 Then
        e.i = pi.i
        e.j = pi.j
        v = setnet_sub1(f2, e)
        If v.len = -1 Then
            flg = 7
            cflg = cflg + 1
            Call c2_Click
            Exit Sub
        Else
            greal.GridLines = flexGridNone
            For i = 0 To v.len Step 1
                max = (i + 1) Mod (v.len + 1)
                If v.e(i).j = v.e(max).j Then
                    j = IIf(v.e(i).i < v.e(max).i, v.e(i).i, v.e(max).i)
                    k = IIf(v.e(i).i > v.e(max).i, v.e(i).i, v.e(max).i)
                    For l = j To k Step 1
                        f2.row = l
                        f2.col = v.e(i).j
                        f2.CellBackColor = RGB(182, 182, 182)
                    Next l
                Else
                    j = IIf(v.e(i).j < v.e(max).j, v.e(i).j, v.e(max).j)
                    k = IIf(v.e(i).j > v.e(max).j, v.e(i).j, v.e(max).j)
                    For l = j To k Step 1
                        f2.row = v.e(i).i
                        f2.col = l
                        f2.CellBackColor = RGB(182, 182, 182)
                    Next l
                End If
                
                    If i <> 0 Then
                        f2.row = v.e(i).i
                        f2.col = v.e(i).j
                        If i Mod 2 = 0 Then
                            f2.CellBackColor = RGB(0, 300, 300)
                        Else
                            f2.CellBackColor = RGB(300, 300, 0)
                        End If
                    End If
            Next i
                  
                  f2.row = v.e(0).i
                  f2.col = v.e(0).j
                  f2.CellBackColor = RGB(0, 300, 0)
            c2.Enabled = False
            c3.Enabled = True
            flg = 5
            cflg = cflg + 1
        End If
    End If
End If
Call real_process

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub c3_Click()
On Error GoTo xit
If flg = 5 Then
    Call setnet_sub2(f2, v)
        flg = 2
        Call real_process
    If all_allocated(f2) Then
        flg = 3
        c3.Enabled = False
        c1.Enabled = True
    Else
        c1.Caption = "&E-allocation"
        c1.ToolTipText = "To make total_allocation=m+n-1"
        flg = 2
        c3.Enabled = False
        c1.Enabled = True
    End If
    cflg = cflg + 1
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub c4_Click()
On Error GoTo xit
    Call Form_load
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub cexit_Click()
    Unload Me
End Sub

Private Sub cprev_Click()
On Error GoTo xit
Dim oldc As Long


oldc = cflg - 1
Call Form_load
gridflg = False
ssbar.Panels(1).Text = "Finding previous step, please wait..."
Do While cflg < oldc
    If cflg = oldc - 1 Then gridflg = True
    If c1.Enabled Then
        Call c1_Click
    Else
        If c2.Enabled Then
            Call c2_Click
        Else
            If c3.Enabled Then
                Call c3_Click
            Else
                Exit Do
            End If
        End If
    End If
Loop
gridflg = True
Call real_process
ssbar.Panels(1).Text = "Step by step solving model"
If cflg = 0 Then cprev.Enabled = False
Exit Sub
xit:
    Call error_me(Me)
End Sub



Private Sub Form_load()
On Error GoTo xit
Dim Y As New Recordset
Dim Tpp_id As Long
Dim maxflg As Boolean
Dim i As Integer
Dim j As Integer
Dim ssum As Double
Dim dsum As Double


gridflg = True
ssbar.Panels(1).Text = "Step by step solving model"
Tpp_id = metid
flg = 0
cflg = 0
cprev.Enabled = False
greal.GridLines = flexGridFlat
c1.Enabled = True
c2.Enabled = False
c3.Enabled = False
c4.Enabled = True
c1.Caption = "&Find Pivot"
c1.ToolTipText = "Finds pivotal element for allocation"
c2.Caption = "&Allocate On Pivot"
c2.ToolTipText = "Allocate Maximum feasible amount on pivot"
c3.Caption = "Allocate &On Circuit"
c3.ToolTipText = "Allocate on transition cells in the circuit"
c4.Caption = "&Reset"
f1.clear
f2.clear
f3.clear
greal.clear
f1.rows = 1
f1.cols = 1
f2.rows = 1
f2.cols = 1
f3.rows = 1
f3.cols = 1
Call connect
Set Y = dn.cn.Execute("select nsrc,ndst,t_type from tpp_main where tid=" & Tpp_id & "")
f1.cols = Val(Y.Fields("ndst")) + 2
f1.rows = Val(Y.Fields("nsrc")) + 2

f1.FixedCols = 1
f1.FixedRows = 1
    
For i = 1 To f1.cols - 2 Step 1
   f1.TextMatrix(0, i) = "DST" & Trim(str(i))
Next i

For i = 1 To f1.rows - 2 Step 1
    f1.TextMatrix(i, 0) = "SRC" & Trim(str(i))
Next i

f1.TextMatrix(0, f1.cols - 1) = "CAPS"
f1.TextMatrix(f1.rows - 1, 0) = "REQS"
f1.TextMatrix(f1.rows - 1, f1.cols - 1) = ""

maxflg = IIf(Y.Fields("t_type") = "MA", True, False)
max = maxflg
Set Y = dn.cn.Execute("select sdno,recap from tpp_sub1 where(tid=" & Tpp_id & " and sord='S') order by sdno")
Y.MoveFirst
For i = 1 To f1.rows - 2 Step 1
    f1.TextMatrix(i, f1.cols - 1) = Trim(Y.Fields("recap"))
    Y.MoveNext
Next i
Set Y = dn.cn.Execute("select sdno,recap from tpp_sub1 where(tid=" & Tpp_id & " and sord='D') order by sdno")
Y.MoveFirst
For i = 1 To f1.cols - 2 Step 1
    f1.TextMatrix(f1.rows - 1, i) = Trim(Y.Fields("recap"))
    Y.MoveNext
Next i

Set Y = dn.cn.Execute("select srcid,dstid,cost from tpp_sub2 where tid=" & Tpp_id)
Y.MoveFirst
While Not Y.EOF
    f1.TextMatrix(Y.Fields("srcid"), Y.Fields("dstid")) = Trim(Y.Fields("cost"))
    Y.MoveNext
Wend

If maxflg Then
    Set Y = dn.cn.Execute("select max(cost) as cst from tpp_sub2 where tid=" & Tpp_id)
    For i = 1 To f1.rows - 2 Step 1
        For j = 1 To f1.cols - 2 Step 1
            f1.TextMatrix(i, j) = Trim(str(Val(Y.Fields("cst")) - f1.TextMatrix(i, j)))
        Next j
    Next i
End If

Set Y = dn.cn.Execute("select sum(recap)as s from tpp_sub1 where(tid=" & Tpp_id & " and sord='S')")
ssum = Val(Y.Fields("s"))
Set Y = dn.cn.Execute("select sum(recap)as s from tpp_sub1 where(tid=" & Tpp_id & " and sord='D')")
dsum = Val(Y.Fields("s"))
If ssum <> dsum Then
    If ssum < dsum Then
        f1.rows = f1.rows + 1
        For j = 0 To f1.cols - 1 Step 1
            f1.TextMatrix(f1.rows - 1, j) = Trim(f1.TextMatrix(f1.rows - 2, j))
            f1.TextMatrix(f1.rows - 2, j) = "0"
        Next j
        f1.TextMatrix(f1.rows - 2, 0) = "D-SRC"
        f1.TextMatrix(f1.rows - 2, f1.cols - 1) = Trim(str(dsum - ssum))
    Else
        f1.cols = f1.cols + 1
        For i = 0 To f1.rows - 1 Step 1
            f1.TextMatrix(i, f1.cols - 1) = Trim(f1.TextMatrix(i, f1.cols - 2))
            f1.TextMatrix(i, f1.cols - 2) = "0"
        Next i
        f1.TextMatrix(0, f1.cols - 2) = "D-DST"
        f1.TextMatrix(f1.rows - 1, f1.cols - 2) = Trim(str(ssum - dsum))
    End If
End If

Call copy_grid1togrid2(f1, f2, False, True)

If method = "VAM" Then
    f2.rows = f2.rows + 1
    f2.cols = f2.cols + 1
    f2.TextMatrix(0, f2.cols - 1) = "DIFF"
    f2.TextMatrix(f2.rows - 1, 0) = "DIFF"
End If
Call real_process

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

Private Sub real_process()
On Error GoTo xit
Dim i As Integer
Dim j As Integer

If Not gridflg Then Exit Sub

If flg = 0 Or flg = 1 Or flg = 2 Then
    greal.clear
    greal.rows = 1
    greal.cols = 1
    greal.rows = f2.rows
    greal.cols = f2.cols
    greal.FixedCols = f2.FixedCols
    greal.FixedRows = f2.FixedRows
    For j = 0 To greal.cols - 1 Step 1
        greal.ColWidth(j) = 1500
    Next j
    Call copy_head(f2, greal)
    greal.TextMatrix(0, 0) = IIf(max, "Max", "Min")
    If (flg = 0 Or flg = 1) And method = "VAM" Then
        For i = 1 To f2.rows - 3 Step 1
            For j = 1 To f2.cols - 3 Step 1
                greal.row = i
                f2.row = i
                greal.col = j
                f2.col = j
                greal.CellBackColor = f2.CellBackColor
                greal.CellAlignment = 3
                greal.TextMatrix(i, j) = Trim(f1.TextMatrix(i, j)) & IIf(Trim(f2.TextMatrix(i, j)) <> "0", "  [" & Trim(f2.TextMatrix(i, j)) & "]", " ")
            Next j
            
            For j = f2.cols - 2 To f2.cols - 1 Step 1
                greal.row = i
                f2.row = i
                greal.col = j
                f2.col = j
                greal.CellBackColor = f2.CellBackColor
                greal.CellAlignment = 3
                greal.TextMatrix(i, j) = Trim(f2.TextMatrix(i, j))
            Next j
        Next i
        For j = 1 To f2.cols - 3 Step 1
            For i = f2.rows - 2 To f2.rows - 1 Step 1
                greal.row = i
                f2.row = i
                greal.col = j
                f2.col = j
                greal.CellBackColor = f2.CellBackColor
                greal.CellAlignment = 3
                greal.TextMatrix(i, j) = Trim(f2.TextMatrix(i, j))
            Next i
        Next j
            greal.row = 0
            greal.col = greal.cols - 2
            greal.CellBackColor = RGB(80, 0, 80)
            greal.row = greal.rows - 2
            greal.col = 0
            greal.CellBackColor = RGB(80, 0, 80)
    Else
        For i = 1 To f2.rows - 2 Step 1
            For j = 1 To f2.cols - 2 Step 1
                greal.row = i
                f2.row = i
                greal.col = j
                f2.col = j
                greal.CellBackColor = f2.CellBackColor
                greal.CellAlignment = 3
                greal.TextMatrix(i, j) = Trim(f1.TextMatrix(i, j)) & IIf(Trim(f2.TextMatrix(i, j)) <> "0", "  [" & Trim(f2.TextMatrix(i, j)) & "]", "")
            Next j
            greal.row = i
            f2.row = i
            greal.col = greal.cols - 1
            f2.col = greal.cols - 1
            greal.CellBackColor = f2.CellBackColor
            greal.CellAlignment = 3
            greal.TextMatrix(i, greal.cols - 1) = Trim(f2.TextMatrix(i, greal.cols - 1))
        Next i
        
        For j = 1 To f2.cols - 2 Step 1
                greal.row = greal.rows - 1
                f2.row = greal.rows - 1
                greal.col = j
                f2.col = j
                greal.CellBackColor = f2.CellBackColor
                greal.CellAlignment = 3
                greal.TextMatrix(greal.rows - 1, j) = Trim(f2.TextMatrix(greal.rows - 1, j))
        Next j
    End If
Else
    If flg = 3 Or flg = 4 Or flg >= 5 Then
        greal.clear
        greal.rows = 1
        greal.cols = 1
        greal.rows = f2.rows
        greal.cols = f2.cols
        greal.FixedCols = f2.FixedCols
        greal.FixedRows = f2.FixedRows
        For j = 0 To greal.cols - 1 Step 1
            greal.ColWidth(j) = 1500
        Next j
        Call copy_head(f1, greal)
        greal.TextMatrix(0, 0) = IIf(max, "MAX", "MIN")
        greal.TextMatrix(0, greal.cols - 1) = "Vj"
        greal.TextMatrix(greal.rows - 1, 0) = "Ui"
        For i = 1 To greal.rows - 2 Step 1
            For j = 1 To greal.cols - 2 Step 1
                greal.row = i
                f2.row = i
                greal.col = j
                f2.col = j
                greal.CellBackColor = f2.CellBackColor
                greal.CellAlignment = 3
                greal.TextMatrix(i, j) = Trim(f1.TextMatrix(i, j)) & IIf(Trim(f2.TextMatrix(i, j)) <> "0", "  [" & Trim(f2.TextMatrix(i, j)) & "]", "  {" & Trim(f3.TextMatrix(i, j)) & "}")
            Next j
            greal.row = i
            f2.row = i
            greal.col = greal.cols - 1
            f2.col = greal.cols - 1
            greal.CellBackColor = f2.CellBackColor
            greal.CellAlignment = 3
            greal.TextMatrix(i, greal.cols - 1) = Trim(f3.TextMatrix(i, greal.cols - 1))
        Next i
        
        For j = 1 To greal.cols - 2 Step 1
            greal.row = greal.rows - 1
            f2.row = greal.rows - 1
            greal.col = j
            f2.col = j
            greal.CellBackColor = f2.CellBackColor
            greal.CellAlignment = 3
            greal.TextMatrix(greal.rows - 1, j) = Trim(f3.TextMatrix(greal.rows - 1, j))
        Next j
    End If
End If
greal.row = greal.rows - 1
greal.col = 0
greal.CellBackColor = RGB(0, 80, 0)
greal.row = 0
greal.col = greal.cols - 1
greal.CellBackColor = RGB(0, 80, 0)
greal.row = greal.rows - 1
greal.col = greal.cols - 1
greal.CellBackColor = RGB(0, 80, 0)
Exit Sub
xit:
    Call error_me(Me)
End Sub



Private Sub mexit_Click()
    Unload Me
End Sub

Private Sub prblm_Click()
On Error GoTo xit

        r.hold = 0
        r.maxp = max
        r.flg = 0
        r.Caption = "TRANSPORTAION PROBLEM DEFINITION"
        r.Show vbModal, Me
        'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub solution_Click()
On Error GoTo xit
Call Form_load
gridflg = False
ssbar.Panels(1).Text = "Finding solution, please wait..."
Do While Not (flg = 8 Or flg = 7 Or flg = 6)
    If c1.Enabled Then
        Call c1_Click
    Else
        If c2.Enabled Then
            Call c2_Click
        Else
            If c3.Enabled Then
                Call c3_Click
            Else
                Exit Do
            End If
        End If
    End If
Loop
gridflg = True
Call real_process
ssbar.Panels(1).Text = "Step by step solving model"
Exit Sub
xit:
    Call error_me(Me)
End Sub
