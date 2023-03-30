VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Begin VB.Form apsolver 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "AP solver"
   ClientHeight    =   7650
   ClientLeft      =   45
   ClientTop       =   660
   ClientWidth     =   11910
   FillStyle       =   0  'Solid
   HelpContextID   =   9
   Icon            =   "apsolver.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7650
   ScaleWidth      =   11910
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cprev 
      BackColor       =   &H80000004&
      Caption         =   "&Previous Step"
      Height          =   495
      Left            =   3615
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Reloads previous iteration"
      Top             =   7080
      Width           =   1455
   End
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      Height          =   495
      Left            =   10800
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "Exit to main menu"
      Top             =   7080
      Width           =   975
   End
   Begin VB.CommandButton c4 
      BackColor       =   &H80000004&
      Caption         =   "&Reset"
      Height          =   495
      Left            =   9825
      Style           =   1  'Graphical
      TabIndex        =   3
      ToolTipText     =   "Clicking on this button will reload the initial Assignment Matrix."
      Top             =   7080
      Width           =   975
   End
   Begin VB.CommandButton c1 
      BackColor       =   &H80000004&
      Caption         =   "NIL"
      Height          =   495
      HelpContextID   =   5
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "Button for initiating differant steps in Hungarian Assignment Method to find an optimal solution."
      Top             =   7080
      Width           =   3495
   End
   Begin VB.Frame freal 
      BackColor       =   &H80000004&
      Caption         =   "Assignment Table"
      ForeColor       =   &H00000000&
      Height          =   6615
      Left            =   120
      TabIndex        =   0
      ToolTipText     =   "Assignmet Matrix(Transformed if Maximization problem)"
      Top             =   120
      Width           =   11775
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid greal 
         Height          =   6255
         Left            =   120
         TabIndex        =   1
         ToolTipText     =   "Assignmet Matrix(Transformed if Maximization problem)"
         Top             =   240
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   11033
         _Version        =   393216
         BackColor       =   16777215
         ForeColor       =   0
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorSel    =   -2147483644
         BackColorBkg    =   -2147483644
         GridColorFixed  =   0
         GridLines       =   3
         BorderStyle     =   0
         RowSizingMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BeginProperty FontFixed {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
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
   Begin ComctlLib.StatusBar ssbar 
      Align           =   2  'Align Bottom
      Height          =   345
      Left            =   0
      TabIndex        =   6
      Top             =   7305
      Width           =   11910
      _ExtentX        =   21008
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
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu solution 
         Caption         =   "Solution"
         Shortcut        =   ^S
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu xit 
         Caption         =   "Exit"
         Shortcut        =   ^E
      End
   End
End
Attribute VB_Name = "apsolver"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public Ap_id  As Long
Public hold As Long
Dim lne As line
Dim flg As Integer
Dim cflg As Long
Dim f1 As Boolean
Dim f2 As Boolean
Dim gridflg As Boolean



Private Sub c1_Click()
On Error GoTo xit
Dim i As Integer
Dim tmp As ap
Dim tmp1 As Boolean
Dim tmp2 As Boolean

If flg = 0 Then
    Call hungarian_rowtran(aptab)
    flg = 1
    cprev.Enabled = True
    c1.Caption = "&Transform Columns"
    cflg = cflg + 1
Else
If flg = 1 Then
     Call hungarian_coltran(aptab)
     flg = 2
     c1.Caption = "&Make Row Assignments"
     cflg = cflg + 1
Else
If flg = 2 Then
    f1 = make_asst_rowwise(aptab)
    Call reload_grid(greal)
    flg = 3
    c1.Caption = "&Make Column Assignments"
    cflg = cflg + 1
    Exit Sub
Else
If flg = 3 Then
    f2 = make_asst_colwise(aptab)
    If Not (f1 Or f2) Then
        flg = 4
        flg = findcase(aptab)
        Select Case flg
            Case 1: flg = 5
                    c1.Caption = "&Show me Optimal Assignment"
            Case 2: flg = 6
                    c1.Caption = "&Make Arbitarary Row Assignments"
            Case Else: flg = 8
                    c1.Caption = "&Draw Lines"
        End Select
    Else
        flg = findcase(aptab)
        If flg = 1 Then
            flg = 5
            c1.Caption = "&Show me Optimal Assignment"
        Else
            tmp = aptab
            tmp1 = make_asst_rowwise(tmp)
            tmp2 = make_asst_colwise(tmp)
            If Not (tmp1 Or tmp2) Then
                flg = 6
                c1.Caption = "&Make Arbitarary Row Assignments"
            Else
                flg = 2
                c1.Caption = "&Make Row Assignments"
            End If
        End If
    End If
    Call reload_grid(greal)
    cflg = cflg + 1
    Exit Sub
Else
If flg = 5 Then
        Call grid_clr(greal, 300, 300, 300)
        r.hold = 2
        r.maxp = aptab.ismax
        r.flg = 1
        r.Caption = "ASSIGNMENT PROBLEM DEFINITION"
        r.Show vbModal, Me
        'me.hide
Else
If flg = 6 Then
    f1 = ummrk_mrk_rowwise(aptab)
    flg = 7
    c1.Caption = "&Make Arbitarary Column Assignments"
    Call reload_grid(greal)
    cflg = cflg + 1
    Exit Sub
Else
If flg = 7 Then
    f2 = ummrk_mrk_colwise(aptab)
    If Not (f1 Or f2) Then
        flg = 8
        c1.Caption = "&Draw Lines"
    Else
        tmp = aptab
        tmp1 = ummrk_mrk_rowwise(tmp)
        tmp2 = ummrk_mrk_colwise(tmp)
        If Not (tmp1 Or tmp2) Then
            flg = 8
            c1.Caption = "&Draw lines"
        Else
            flg = 6
            c1.Caption = "&Make Arbitarary Row Assignments"
        End If
    End If
    Call reload_grid(greal)
    cflg = cflg + 1
    Exit Sub
Else
If flg = 8 Then
    lne = draw_lines(aptab)
    If lne.redo Then
        flg = 9
        c1.Caption = "&Load Transformed Assignment Matrix"
    Else
        flg = 5
        c1.Caption = "&Show me Optimal Assignment"
    End If
    Call reload_grid(greal)
    cflg = cflg + 1
    Exit Sub
Else
If flg = 9 Then
    Call grid_clr(greal, 300, 300, 300)
    Call remake_apmatrix(aptab, lne)
    Call clear_cross(cross)
    For i = 0 To lne.m - 1 Step 1
        lne.cap(i) = False
        lne.req(i) = False
    Next i
    lne.redo = False
    flg = 2
    c1.Caption = "&Make Row Assignments"
    cflg = cflg + 1
End If
End If
End If
End If
End If
End If
End If
End If
End If

Call reload_grid(greal)
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
Dim oldflg As Long

oldflg = cflg - 1
Call Form_load
gridflg = False
ssbar.Panels(1).Text = "Finding previous step, please wait..."
While cflg < oldflg
    If cflg = oldflg - 1 Then gridflg = True
    Call c1_Click
Wend
If cflg = 0 Then cprev.Enabled = False
gridflg = True
ssbar.Panels(1).Text = "Step by step solving model"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_load()
On Error GoTo xit
Dim Y As New Recordset
Dim i As Integer
Dim j As Integer

Call connect
gridflg = True
ssbar.Panels(1).Text = "Step by step solving model"
Set Y = dn.cn.Execute("select nsrc,ndst,t_type from tpp_main where tid=" & Ap_id & "")
aptab.f.m = Val(Y.Fields("nsrc"))
aptab.d.n = Val(Y.Fields("ndst"))
aptab.ismax = IIf(Y.Fields("t_type") = "MA", True, False)
cross.m = aptab.f.m
cross.n = aptab.d.n
Call clear_cross(cross)
lne.m = aptab.f.m
lne.n = aptab.d.n
lne.redo = False
i = lne.m - 1
ReDim aptab.f.cap(i) As Boolean
ReDim aptab.d.req(i) As Boolean
ReDim aptab.alloc(i, i) As Boolean
ReDim aptab.table(i, i) As Double
ReDim lne.cap(i) As Boolean
ReDim lne.req(i) As Boolean

For i = 0 To lne.m - 1 Step 1
   lne.cap(i) = False
   lne.req(i) = False
   aptab.f.cap(i) = True
   aptab.d.req(i) = True
Next i

Set Y = dn.cn.Execute("select srcid,dstid,cost from tpp_sub2 where tid=" & Ap_id)
Y.MoveFirst
While Not Y.EOF
    aptab.table(Y.Fields("srcid") - 1, Y.Fields("dstid") - 1) = Trim(Y.Fields("cost"))
    aptab.alloc(Y.Fields("srcid") - 1, Y.Fields("dstid") - 1) = False
    Y.MoveNext
Wend

aptab_real = aptab

If aptab.ismax Then
    Set Y = dn.cn.Execute("select max(cost) as cst from tpp_sub2 where tid=" & Ap_id)
    For i = 0 To aptab.f.m - 1 Step 1
        For j = 0 To aptab.d.n - 1 Step 1
            aptab.table(i, j) = Trim(str(Val(Y.Fields("cst")) - aptab.table(i, j)))
        Next j
    Next i
End If

flg = 0
cflg = 0
cprev.Enabled = False
c1.Caption = "&Transform Rows"

Call reload_grid(greal)
Exit Sub
xit:
    Call error_me(Me)
End Sub

Public Sub reload_grid(x As MSHFlexGrid)
On Error GoTo xit
Dim i As Integer
Dim j As Integer
Dim k As Integer


If Not gridflg Then Exit Sub

x.rows = 1
x.cols = 1
x.rows = aptab.f.m + 2
x.cols = aptab.d.n + 2
x.FixedCols = 1
x.FixedRows = 1

For i = 0 To x.rows - 1 Step 1
    For j = 0 To x.cols - 1 Step 1
        x.row = i
        x.col = j
        x.CellAlignment = 3
    Next j
Next i

For j = 0 To greal.cols - 1 Step 1
        greal.ColWidth(j) = 1600
Next j
x.TextMatrix(0, 0) = IIf(aptab.ismax, "Max", "Min")
x.TextMatrix(0, x.cols - 1) = "Cap"
x.TextMatrix(x.rows - 1, 0) = "Req"
For i = 1 To greal.rows - 2 Step 1
    x.TextMatrix(i, x.cols - 1) = "1"
    x.TextMatrix(x.rows - 1, i) = "1"
    x.TextMatrix(0, i) = "Job" & Trim(str(i))
    x.TextMatrix(i, 0) = "Mac-" & Trim(str(i))
Next i

For i = 0 To aptab.f.m - 1 Step 1
    For j = 0 To aptab.d.n - 1 Step 1
        x.TextMatrix(i + 1, j + 1) = IIf(aptab.alloc(i, j), "[" & aptab.table(i, j) & "]", aptab.table(i, j))
    Next j
Next i
    
For i = 0 To lne.m - 1 Step 1
    If lne.cap(i) Then
        For j = 1 To x.cols - 1 Step 1
            x.row = i + 1
            x.col = j
            x.CellBackColor = RGB(182, 182, 182)
        Next j
    End If
Next i

For j = 0 To lne.n - 1 Step 1
    If lne.req(j) Then
        For i = 1 To x.rows - 1 Step 1
            x.row = i
            x.col = j + 1
            x.CellBackColor = RGB(182, 182, 182)
        Next i
   End If
Next j

For i = 0 To cross.m - 1 Step 1
    For j = 0 To cross.n - 1 Step 1
         If cross.crs(i, j) Then
            x.row = i + 1
            x.col = j + 1
            x.CellFontStrikeThrough = True
        Else
            x.row = i + 1
            x.col = j + 1
            x.CellFontStrikeThrough = False
        End If
    Next j
Next i

x.row = x.rows - 1
x.col = 0
x.CellBackColor = RGB(0, 80, 0)
x.row = 0
x.col = x.rows - 1
x.CellBackColor = RGB(0, 80, 0)
x.row = x.rows - 1
x.col = x.cols - 1
x.CellBackColor = RGB(0, 80, 0)
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

Private Sub prblm_Click()
On Error GoTo xit
        r.hold = 2
        r.maxp = aptab.ismax
        r.flg = 0
        r.Caption = "ASSIGNMENT PROBLEM DEFINITION"
        r.Show vbModal, Me
        'me.hide
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub solution_Click()
On Error GoTo xit

gridflg = False
ssbar.Panels(1).Text = "Finding solution, please wait..."
While flg <> 5
    Call c1_Click
Wend
gridflg = True
Call c1_Click
ssbar.Panels(1).Text = "Step by step solving model"
Exit Sub

xit:
    Call error_me(Me)
End Sub

Private Sub xit_Click()
    Unload Me
End Sub
