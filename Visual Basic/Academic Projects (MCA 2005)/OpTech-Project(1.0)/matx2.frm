VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form matx2 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "THE MATRIX RANKER"
   ClientHeight    =   8310
   ClientLeft      =   45
   ClientTop       =   660
   ClientWidth     =   11880
   FillStyle       =   0  'Solid
   HelpContextID   =   13
   Icon            =   "matx2.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8310
   ScaleWidth      =   11880
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cprev 
      BackColor       =   &H80000004&
      Caption         =   "&Previous Step"
      Height          =   495
      Left            =   4320
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Reloads previous state of the matrix"
      Top             =   7140
      Width           =   2415
   End
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      Height          =   495
      Left            =   10920
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "Quit to main menu"
      Top             =   7140
      Width           =   855
   End
   Begin VB.CommandButton c2 
      BackColor       =   &H80000004&
      Caption         =   "&Reset"
      Height          =   495
      Left            =   10065
      Style           =   1  'Graphical
      TabIndex        =   3
      ToolTipText     =   "Clicking on this button will reload the initial Matrix"
      Top             =   7140
      Width           =   855
   End
   Begin VB.CommandButton c1 
      BackColor       =   &H80000004&
      Caption         =   "NIL"
      Height          =   495
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "Initiate differant matrix transformation operations"
      Top             =   7140
      Width           =   4215
   End
   Begin VB.Frame fmat 
      BackColor       =   &H80000004&
      Caption         =   "Matrix under transformation"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   6825
      Left            =   105
      TabIndex        =   0
      ToolTipText     =   "Matrix under transformation"
      Top             =   120
      Width           =   11775
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gmat 
         Height          =   6495
         Left            =   120
         TabIndex        =   1
         ToolTipText     =   "Matrix under transformation"
         Top             =   255
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   11456
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
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BeginProperty FontFixed {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Bookman Old Style"
            Size            =   9.75
            Charset         =   0
            Weight          =   600
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
      Top             =   7965
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   609
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   2
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
Attribute VB_Name = "matx2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public opt As Long
Public id_ As Long
Public hold As Long
Dim flg As Long
Dim cflg As Long
Dim org As matrix
Dim tmp As matrix
Dim piv As rat
Dim i As Long
Dim oldclr As Long
Dim gridflg As Boolean

Private Sub process_grid(m As matrix, flg As Long)
On Error GoTo xit
Dim i As Long
Dim j As Long

If Not gridflg Then Exit Sub

With gmat
If opt = 0 Then
    If flg = -1 Then
        Call map_matrix_grid(tmp, gmat)
        .row = 0
        .col = 0
        .CellAlignment = 3
        .TextMatrix(0, 0) = "MATRIX"
    End If
    If flg = 0 Then
        For i = 1 To gmat.rows - 1 Step 1
            For j = 1 To gmat.cols - 1 Step 1
                .row = i
                .col = j
                .CellBackColor = oldclr
            Next j
        Next i
        .row = piv.a + tmp.rank + 1
        .col = piv.b + tmp.rank + 1
        .CellBackColor = RGB(300, 300, 0)
    End If
    If flg = 1 Or flg = 2 Or flg = 3 Then
        For i = 0 To tmp.rows - 1 Step 1
            For j = 0 To tmp.cols - 1 Step 1
                .row = tmp.rank + i + 1
                .col = tmp.rank + j + 1
                .CellAlignment = 3
                .CellBackColor = oldclr
                .TextMatrix(tmp.rank + i + 1, tmp.rank + j + 1) = rat_stg(tmp.matx(i, j))
            Next j
        Next i
        If flg = 1 Then
            .row = tmp.rank + 1
            .col = piv.b + tmp.rank + 1
            .CellBackColor = RGB(300, 300, 0)
        ElseIf flg = 2 Then
            .row = piv.a + tmp.rank + 1
            .col = tmp.rank + 1
            .CellBackColor = RGB(300, 300, 0)
        End If
    End If
    If flg = 4 Then
        For i = 1 To gmat.rows - 1 Step 1
            For j = 1 To gmat.cols - 1 Step 1
                .row = i
                .col = j
                .CellBackColor = oldclr
            Next j
        Next i
    End If
End If

If opt = 1 Then
    If flg = -1 Then
        Call map_matrix_grid(tmp, gmat)
        .row = 0
        .col = 0
        .CellAlignment = 3
        .TextMatrix(0, 0) = "MATRIX"
    End If
    If flg = 0 Then
        For i = 1 To gmat.rows - 1 Step 1
            For j = 1 To gmat.cols - 1 Step 1
                .row = i
                .col = j
                .CellBackColor = oldclr
            Next j
        Next i
        .row = piv.a + 1
        .col = piv.b + 1
        .CellBackColor = RGB(300, 300, 0)
    End If
    If flg = 1 Or flg = 3 Then
        For i = 0 To tmp.rows - 1 Step 1
            For j = 0 To tmp.cols - 1 Step 1
                .row = i + 1
                .col = j + 1
                .CellAlignment = 3
                .CellBackColor = oldclr
                .TextMatrix(i + 1, j + 1) = rat_stg(tmp.matx(i, j))
            Next j
        Next i
        If flg = 1 Then
            .row = piv.a
            .col = piv.b + 1
            .CellBackColor = RGB(300, 300, 0)
        End If
    End If
    If flg = 4 Then
        For i = 1 To gmat.rows - 1 Step 1
            For j = 1 To gmat.cols - 1 Step 1
                .row = i
                .col = j
                .CellBackColor = oldclr
            Next j
        Next i
    End If
End If
End With

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub c1_Click()
On Error GoTo xit
Dim t1 As Long
    
    If opt = 0 Then
        If flg = 0 Then
            If rank_pivot(tmp.matx, tmp.rows, tmp.cols, piv) Then
                Call process_grid(tmp, flg)
                If piv.a > 0 Then
                    flg = 1
                    c1.Caption = "&Interchange Row-" + Trim(str(tmp.rank + 1)) + " with Pivot Row(" + Trim(str(tmp.rank + piv.a + 1)) + ")"
                ElseIf piv.b > 0 Then
                    flg = 2
                    c1.Caption = "&Interchange Column-" + Trim(str(tmp.rank + 1)) + " with Pivot Column(" + Trim(str(tmp.rank + piv.b + 1)) + ")"
                Else
                    flg = 3
                    c1.Caption = "Reduce Pivot to &unity"
                End If
            Else
                flg = 4
                c1.Caption = "&Show Result"
            End If
            cprev.Enabled = True
            cflg = cflg + 1
        ElseIf flg = 1 Then
            t1 = piv.a
            Call chngerows(tmp.matx, 0, t1, tmp.rows, tmp.cols)
            Call process_grid(tmp, flg)
            If piv.b > 0 Then
                flg = 2
                c1.Caption = "&Interchange Column-" + Trim(str(tmp.rank + 1)) + " with Pivot Column(" + Trim(str(tmp.rank + piv.b + 1)) + ")"
            Else
                flg = 3
                c1.Caption = "Reduce Pivot to &unity"
            End If
            cflg = cflg + 1
        ElseIf flg = 2 Then
            t1 = piv.b
            Call chngecols(tmp.matx, 0, t1, tmp.rows, tmp.cols)
            Call process_grid(tmp, flg)
            flg = 3
            c1.Caption = "Reduce Pivot to &unity"
            cflg = cflg + 1
        ElseIf flg = 3 Then
            Call rank_pivot_tounity(tmp.matx, tmp.rows, tmp.cols)
            Call process_grid(tmp, flg)
            tmp.rank = tmp.rank + 1
            If rank_pivot_tounity_sub(tmp.matx, tmp.rows, tmp.cols) Then
                flg = 0
                c1.Caption = "&Find Pivot"
            Else
                flg = 4
                c1.Caption = "&Show Result"
            End If
            cflg = cflg + 1
            Exit Sub
        ElseIf flg = 4 Then
            Call process_grid(tmp, flg)
            tmp1_matx = org
            tmp1_matx.rank = tmp.rank
            r.hold = 7
            r.flg = 1
            r.Show vbModal, Me
            'me.hide
        End If
    End If
    
     If opt = 1 Then
        If flg = 0 Then
            If row_rank_pivot(i, tmp, piv) Then
                Call process_grid(tmp, flg)
                If piv.a <> i Then
                    flg = 1
                    c1.Caption = "&Interchange Row-" + Trim(str(i + 1)) + " with Pivot Row(" + Trim(str(piv.a + 1)) + ")"
                Else
                    flg = 3
                    c1.Caption = "Reduce Pivot to &unity"
                End If
            Else
                flg = 4
                c1.Caption = "&Show Result"
            End If
            cprev.Enabled = True
            cflg = cflg + 1
        ElseIf flg = 1 Then
            t1 = piv.a
            Call chngerows(tmp.matx, i, t1, tmp.rows, tmp.cols)
            Call process_grid(tmp, flg)
            flg = 3
            c1.Caption = "Reduce Pivot to &unity"
            cflg = cflg + 1
        ElseIf flg = 3 Then
            Call row_rank_pivot_tounity(i, tmp.matx, tmp.rows, tmp.cols, piv)
            Call process_grid(tmp, flg)
            If i <= tmp.rows - 1 Then
                If row_rank_pivot(i, tmp, piv) Then
                    flg = 0
                    c1.Caption = "&Find Pivot"
                    tmp.rank = tmp.rank - 1
                Else
                    Call rowcanon_finalize(tmp)
                    flg = 4
                    c1.Caption = "&Show Result"
                End If
            Else
                Call rowcanon_finalize(tmp)
                flg = 4
                c1.Caption = "&Show Result"
            End If
            cflg = cflg + 1
            Exit Sub
        ElseIf flg = 4 Then
            Call process_grid(tmp, flg)
            tmp1_matx = org
            tmp1_matx.rank = tmp.rank
            tmp2_matx = tmp
            r.hold = 7
            r.flg = 1
            r.Show vbModal, Me
            'me.hide
        End If
    End If
    
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub c2_Click()
    Call Form_load
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
    While cflg < oldc
        If cflg = oldc - 1 Then gridflg = True
        Call c1_Click
    Wend
    gridflg = True
    If cflg = 0 Then cprev.Enabled = False
    ssbar.Panels(1).Text = "Step by step solving model"
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_load()
On Error GoTo xit

    gridflg = True
    ssbar.Panels(1).Text = "Step by step solving model"
    If opt = 0 Then
        oldclr = RGB(300, 300, 300)
        flg = -1
        Me.Caption = "The Matrix Ranker"
        c1.Caption = "&Find Pivot"
        Call create_matrix(id_, org)
        Call cpymatx(org.matx, org.rows, org.cols, tmp.matx)
        tmp.rows = org.rows
        tmp.cols = org.cols
        tmp.rank = 0
        Call process_grid(tmp, flg)
        flg = 0
    End If
    
    If opt = 1 Then
        oldclr = RGB(300, 300, 300)
        flg = -1
        i = 0
        Me.Caption = "The Matrix Ranker(Row Reduced Echelon Form)"
        c1.Caption = "&Find Pivot"
        Call create_matrix(id_, org)
        Call cpymatx(org.matx, org.rows, org.cols, tmp.matx)
        tmp.rows = org.rows
        tmp.cols = org.cols
        tmp.rank = 0
        Call process_grid(tmp, flg)
        flg = 0
    End If
    cprev.Enabled = False
    cflg = 0
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

Private Sub mexit_Click()
    Unload Me
End Sub

Private Sub prblm_Click()
On Error GoTo xit
    tmp1_matx = org
    r.hold = 7
    r.flg = 0
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
    While flg < 4
        Call c1_Click
    Wend
    gridflg = True
    Call c1_Click
    ssbar.Panels(1).Text = "Step by step solving model"
Exit Sub
xit:
    Call error_me(Me)
End Sub
