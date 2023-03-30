VERSION 5.00
Begin VB.Form foptions 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Select Option"
   ClientHeight    =   6090
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   8445
   Icon            =   "foptions.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   Picture         =   "foptions.frx":0442
   ScaleHeight     =   6090
   ScaleWidth      =   8445
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "Back To Ma&in"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6780
      Style           =   1  'Graphical
      TabIndex        =   45
      ToolTipText     =   "Exit to main menu"
      Top             =   5595
      Width           =   1440
   End
   Begin VB.CommandButton csolve 
      BackColor       =   &H80000004&
      Caption         =   "S&olve"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5340
      Style           =   1  'Graphical
      TabIndex        =   44
      ToolTipText     =   "Solves the problem using method specified"
      Top             =   5595
      Width           =   1440
   End
   Begin VB.PictureBox pls 
      Height          =   735
      Left            =   4260
      ScaleHeight     =   675
      ScaleWidth      =   3915
      TabIndex        =   41
      ToolTipText     =   "Linear system of eqns solving methods"
      Top             =   4680
      Width           =   3975
      Begin VB.OptionButton lsop 
         Caption         =   "Cram&er's Rule"
         Height          =   255
         Index           =   0
         Left            =   0
         TabIndex        =   43
         Top             =   0
         Width           =   3975
      End
      Begin VB.OptionButton lsop 
         Caption         =   "X&=Inverse(A)xB Rule"
         Height          =   255
         Index           =   1
         Left            =   0
         TabIndex        =   42
         Top             =   360
         Width           =   3975
      End
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   11
      Left            =   7575
      TabIndex        =   40
      Top             =   4470
      Width           =   660
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   10
      Left            =   4260
      TabIndex        =   39
      Top             =   4455
      Width           =   765
   End
   Begin VB.PictureBox pm 
      Height          =   1095
      Left            =   4260
      ScaleHeight     =   1035
      ScaleWidth      =   3915
      TabIndex        =   34
      ToolTipText     =   "Available matrix manipulations"
      Top             =   3120
      Width           =   3975
      Begin VB.OptionButton mop 
         Caption         =   "Row &canonical form of Matrix"
         Height          =   255
         Index           =   2
         Left            =   0
         TabIndex        =   37
         Top             =   720
         Width           =   3975
      End
      Begin VB.OptionButton mop 
         Caption         =   "&Rank of Matrix"
         Height          =   255
         Index           =   1
         Left            =   0
         TabIndex        =   36
         Top             =   360
         Width           =   3975
      End
      Begin VB.OptionButton mop 
         Caption         =   "Basic Attrib&utes"
         Height          =   255
         Index           =   0
         Left            =   0
         TabIndex        =   35
         Top             =   0
         Width           =   3975
      End
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   9
      Left            =   7050
      TabIndex        =   33
      Top             =   2880
      Width           =   1200
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   8
      Left            =   4275
      TabIndex        =   32
      Top             =   2865
      Width           =   1155
   End
   Begin VB.PictureBox ps 
      Height          =   1455
      Left            =   300
      ScaleHeight     =   1395
      ScaleWidth      =   3675
      TabIndex        =   26
      ToolTipText     =   "Available Sp solving methods"
      Top             =   3960
      Width           =   3735
      Begin VB.OptionButton sop 
         Caption         =   "&K-Machines 2-Jobs (Grphical Method) "
         Height          =   255
         Index           =   3
         Left            =   0
         TabIndex        =   30
         Top             =   1080
         Width           =   3975
      End
      Begin VB.OptionButton sop 
         Caption         =   "K-Machines &N-Jobs"
         Height          =   255
         Index           =   2
         Left            =   0
         TabIndex        =   29
         Top             =   720
         Width           =   3975
      End
      Begin VB.OptionButton sop 
         Caption         =   "&3-Machines K-Jobs"
         Height          =   255
         Index           =   1
         Left            =   0
         TabIndex        =   28
         Top             =   360
         Width           =   3975
      End
      Begin VB.OptionButton sop 
         Caption         =   "&2-Machines K-Jobs"
         Height          =   255
         Index           =   0
         Left            =   0
         TabIndex        =   27
         Top             =   0
         Width           =   3975
      End
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   7
      Left            =   3060
      TabIndex        =   25
      Top             =   3720
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   6
      Left            =   300
      TabIndex        =   24
      Top             =   3720
      Width           =   810
   End
   Begin VB.PictureBox pa 
      Height          =   360
      Left            =   4260
      ScaleHeight     =   300
      ScaleWidth      =   3915
      TabIndex        =   21
      ToolTipText     =   "Available Ap solving methods"
      Top             =   2280
      Width           =   3975
      Begin VB.OptionButton aop 
         Caption         =   "&Hungarian Assignment Method"
         Height          =   255
         Index           =   0
         Left            =   0
         TabIndex        =   22
         ToolTipText     =   "Available Ap solving methods"
         Top             =   0
         Width           =   3975
      End
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   5
      Left            =   7350
      TabIndex        =   20
      Top             =   2040
      Width           =   885
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   4
      Left            =   4260
      TabIndex        =   19
      Top             =   2010
      Width           =   975
   End
   Begin VB.PictureBox pt 
      Height          =   1095
      Left            =   4260
      ScaleHeight     =   1035
      ScaleWidth      =   3915
      TabIndex        =   14
      ToolTipText     =   "Available Tpp solving methods"
      Top             =   720
      Width           =   3975
      Begin VB.OptionButton trop 
         Caption         =   "North &West Corner Rule"
         Height          =   255
         Index           =   0
         Left            =   0
         TabIndex        =   17
         Top             =   0
         Width           =   3975
      End
      Begin VB.OptionButton trop 
         Caption         =   "M&atrix Minimum Method"
         Height          =   255
         Index           =   1
         Left            =   0
         TabIndex        =   16
         Top             =   360
         Width           =   3975
      End
      Begin VB.OptionButton trop 
         Caption         =   "&Vogal's Approximation Method"
         Height          =   255
         Index           =   2
         Left            =   0
         TabIndex        =   15
         Top             =   720
         Width           =   3975
      End
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   3
      Left            =   7440
      TabIndex        =   13
      Top             =   450
      Width           =   795
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   2
      Left            =   4260
      TabIndex        =   12
      Top             =   465
      Width           =   795
   End
   Begin VB.PictureBox pl 
      Height          =   2535
      Left            =   300
      ScaleHeight     =   2475
      ScaleWidth      =   3675
      TabIndex        =   3
      ToolTipText     =   "Available Lpp solving methods"
      Top             =   720
      Width           =   3735
      Begin VB.OptionButton lop 
         Caption         =   "&Graphical Solution "
         Height          =   255
         Index           =   6
         Left            =   0
         TabIndex        =   10
         Top             =   2160
         Width           =   3975
      End
      Begin VB.OptionButton lop 
         Caption         =   "&Branch And Bound Method"
         Height          =   255
         Index           =   5
         Left            =   0
         TabIndex        =   9
         Top             =   1800
         Width           =   3975
      End
      Begin VB.OptionButton lop 
         Caption         =   "Dual Of &Primal"
         Height          =   255
         Index           =   4
         Left            =   0
         TabIndex        =   8
         Top             =   1440
         Width           =   3975
      End
      Begin VB.OptionButton lop 
         Caption         =   "&Mixed Integer Programming (Fractional Cut)"
         Height          =   255
         Index           =   3
         Left            =   0
         TabIndex        =   7
         Top             =   1080
         Width           =   3975
      End
      Begin VB.OptionButton lop 
         Caption         =   "&Integer Programming (Gomery's Meyhod)"
         Height          =   255
         Index           =   2
         Left            =   0
         TabIndex        =   6
         Top             =   720
         Width           =   3975
      End
      Begin VB.OptionButton lop 
         Caption         =   "&Dual Simplex Method (Big-M included)"
         Height          =   255
         Index           =   1
         Left            =   0
         TabIndex        =   5
         Top             =   360
         Width           =   3975
      End
      Begin VB.OptionButton lop 
         Caption         =   "&Simplex Method (Big-M included)"
         Height          =   255
         Index           =   0
         Left            =   0
         TabIndex        =   4
         Top             =   0
         Width           =   3975
      End
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   1
      Left            =   3060
      TabIndex        =   2
      Top             =   480
      Width           =   990
   End
   Begin VB.Frame Frame1 
      Height          =   165
      Index           =   0
      Left            =   300
      TabIndex        =   1
      Top             =   480
      Width           =   840
   End
   Begin VB.Label Label6 
      Caption         =   "Linear System Of Equations"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5070
      TabIndex        =   38
      Top             =   4455
      Width           =   2475
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Caption         =   "Matrix Properties"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5340
      TabIndex        =   31
      Top             =   2880
      Width           =   1815
   End
   Begin VB.Label Label4 
      Caption         =   "Sequential Problems"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1155
      TabIndex        =   23
      Top             =   3720
      Width           =   1980
   End
   Begin VB.Label Label3 
      Caption         =   "Assignment Problems"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5340
      TabIndex        =   18
      Top             =   2040
      Width           =   2055
   End
   Begin VB.Label Label2 
      Caption         =   "Transportation Problems"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   5145
      TabIndex        =   11
      Top             =   480
      Width           =   2430
   End
   Begin VB.Label Label1 
      Caption         =   "Linear Programming Problem"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1215
      TabIndex        =   0
      Top             =   480
      Width           =   1860
   End
   Begin VB.Menu mxit 
      Caption         =   "E&xit!"
   End
End
Attribute VB_Name = "foptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public tmpid As Long
Public istransaction As Boolean
Public psection As String
Public psubsection As String


Private Sub aop_Click(Index As Integer)
    If Index <> -1 Then
        csolve.Enabled = True
    End If
End Sub


Private Sub cexit_Click()
    Unload Me
End Sub

Private Sub csolve_Click()
On Error GoTo xit
Dim gr As New grapher
Dim org As matrix
Dim cnst As matrix
Dim sol As matrix
Dim tmp As matrix
Dim inv As matrix
Dim i As Long
Dim det As rat
Dim td As rat

    If psection = "LPP" Then
       If lop.item(0).Value Then
            lpp_solve.type_solve = "SOLVE_SIMPLEX"
        ElseIf lop.item(1).Value Then
            lpp_solve.type_solve = "SOLVE_DSIMPLEX"
        ElseIf lop.item(2).Value Then
            lpp_solve.type_solve = "SOLVE_GOMERY"
        ElseIf lop.item(3).Value Then
            lpp_solve.type_solve = "SOLVE_MIXED"
        ElseIf lop.item(4).Value Then
            lpp_solve.type_solve = "DUAL"
        ElseIf lop.item(5).Value Then
            mdi.hold = 1
            mdi.istran = istransaction
            mdi.chois = "BBM"
            mdi.pid = tmpid
            mdi.Show
            Me.Hide
            Exit Sub
        ElseIf lop.item(6).Value Then
            gr.hold = 2
            gr.indx = tmpid
            gr.Show vbModal, Me
            'Me.Hide
            Exit Sub
        End If
        lpp_solve.hold = 1
        lpp_solve.pid = tmpid
        lpp_solve.Show
        Me.Hide
        Exit Sub
    ElseIf psection = "TPP" Then
       If trop.item(0).Value Then
            tpsolver.method = "NWCR"
       ElseIf trop.item(1).Value Then
            tpsolver.method = "MMM"
       ElseIf trop.item(2).Value Then
              tpsolver.method = "VAM"
       End If
        tpsolver.hold = 1
        tpsolver.metid = tmpid
        tpsolver.Show
        Me.Hide
        Exit Sub
    ElseIf psection = "AP" Then
        If aop.item(0).Value Then
            apsolver.hold = 1
        End If
        apsolver.Ap_id = tmpid
        apsolver.Show
        Me.Hide
        Exit Sub
    ElseIf psection = "SP" Then
        If sop.item(0).Value Or sop.item(1).Value Or sop.item(2).Value Then
            spsolver.hold = 1
            With sop
            spsolver.s_type = IIf(.item(0).Value, "SM2", IIf(.item(1).Value, "SM3", "SMK"))
            End With
            spsolver.sp_id = tmpid
            spsolver.Show
            Me.Hide
            Exit Sub
        ElseIf sop.item(3).Value Then
            spj2.hold = 1
            spj2.spj2id = tmpid
            spj2.Show
            Me.Hide
            Exit Sub
        End If
    ElseIf psection = "MATX" Then
        If mop.item(0).Value Then
            matx1.hold = 1
            matx1.id_ = tmpid
            matx1.Show
            Me.Hide
            Exit Sub
        ElseIf mop.item(1).Value Then
            matx2.opt = 0
        ElseIf mop.item(2).Value Then
            matx2.opt = 1
        End If
        matx2.hold = 1
        matx2.id_ = tmpid
        matx2.Show
        Me.Hide
        Exit Sub
    ElseIf psection = "LSOES" Then
        If lsop.item(0).Value Then
            Call create_linear_eqns(tmpid, org, cnst)
            det = detof(org.matx, org.rows, org.cols)
            If rat_neq0(rat_stg(det)) Then
                sol.rows = 1
                sol.cols = org.cols
                ReDim sol.matx(1, org.cols - 1)
                For i = 0 To org.cols - 1 Step 1
                    tmp = org
                    Call replace_column(tmp, i, cnst)
                    td = detof(tmp.matx, tmp.rows, tmp.cols)
                    sol.matx(0, i) = string_rat(ratdiv(rat_stg(td), rat_stg(det)))
                Next i
            Else
                sol.rows = 0
                sol.cols = 0
            End If
            Call create_matrix(tmpid, org)
            tmp1_matx = org
            tmp2_matx = sol
            r.hold = 8
            r.flg = 0
            r.Show vbModal, Me
            'Me.Hide
        ElseIf lsop.item(1).Value Then
            Call create_linear_eqns(tmpid, org, cnst)
            det = detof(org.matx, org.rows, org.cols)
            If rat_neq0(rat_stg(det)) Then
                Call invof(org.matx, org.rows, org.cols, inv.matx, inv.rows, inv.cols)
                Call matmul(inv.matx, inv.rows, inv.cols, cnst.matx, cnst.rows, cnst.cols, tmp.matx, tmp.rows, tmp.cols)
                Call transposeof(tmp.matx, tmp.rows, tmp.cols, sol.matx, sol.rows, sol.cols)
            Else
                sol.rows = 0
                sol.cols = 0
            End If
            Call create_matrix(tmpid, org)
            
            tmp1_matx = org
            tmp2_matx = sol
            r.hold = 8
            r.flg = 1
            r.Show vbModal, Me
            
        End If
    End If
    
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_load()
On Error GoTo xit
Dim i As Long

For i = 0 To Me.Count - 1 Step 1
    If Not TypeOf Me.Controls(i) Is Menu Or Not TypeOf Me.Controls(i) Is Frame Then
        Me.Controls(i).Enabled = False
    End If
Next i
cexit.Enabled = True
If psection = "LPP" Then
    Label1.Enabled = True
    pl.Enabled = True
    For i = lop.LBound To lop.UBound Step 1
        lop.item(i).Enabled = True
    Next i
    If psubsection = "LPPN2" Then
        lop.item(6).Enabled = False
    End If
End If
If psection = "TPP" Then
    Label2.Enabled = True
    pt.Enabled = True
    For i = trop.LBound To trop.UBound Step 1
        trop.item(i).Enabled = True
    Next i
End If
If psection = "MATX" Then
    Label5.Enabled = True
    pm.Enabled = True
    For i = mop.LBound To mop.UBound Step 1
        mop.item(i).Enabled = True
    Next i
End If
If psection = "LSOES" Then
    Label6.Enabled = True
    pls.Enabled = True
    For i = lsop.LBound To lsop.UBound Step 1
        lsop.item(i).Enabled = True
    Next i
End If
If psection = "AP" Then
    Label3.Enabled = True
    pa.Enabled = True
    For i = aop.LBound To aop.UBound Step 1
        aop.item(i).Enabled = True
    Next i
    aop.item(0).Value = True
End If
If psection = "SP" Then
    Label4.Enabled = True
    ps.Enabled = True
    If psubsection = "M2" Then
        sop.item(0).Enabled = True
        sop.item(0).Value = True
    ElseIf psubsection = "M3" Then
        sop.item(1).Enabled = True
        sop.item(1).Value = True
    ElseIf psubsection = "MK" Then
        sop.item(2).Enabled = True
        sop.item(2).Value = True
    ElseIf psubsection = "J2" Then
        sop.item(3).Enabled = True
        sop.item(3).Value = True
    End If
End If

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_Unload(cancel As Integer)
    or_form1.Show
    If istransaction Then
        dn.cn.RollbackTrans
    End If
End Sub

Private Sub lop_Click(Index As Integer)
    If Index <> -1 Then
        csolve.Enabled = True
    End If
End Sub

Private Sub lsop_Click(Index As Integer)
    If Index <> -1 Then
        csolve.Enabled = True
    End If
End Sub

Private Sub mop_Click(Index As Integer)
    If Index <> -1 Then
        csolve.Enabled = True
    End If
End Sub

Private Sub mxit_Click()
    Unload Me
End Sub

Private Sub sop_Click(Index As Integer)
    If Index <> -1 Then
        csolve.Enabled = True
    End If
End Sub

Private Sub trop_Click(Index As Integer)
    If Index <> -1 Then
        csolve.Enabled = True
    End If
End Sub
