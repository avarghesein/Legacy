VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form lppeditor 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "LPP editor"
   ClientHeight    =   8175
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11910
   BeginProperty Font 
      Name            =   "Bookman Old Style"
      Size            =   11.25
      Charset         =   0
      Weight          =   600
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00400000&
   HelpContextID   =   7
   Icon            =   "lppeditor.frx":0000
   LinkTopic       =   "Form1"
   Picture         =   "lppeditor.frx":0442
   ScaleHeight     =   8175
   ScaleWidth      =   11910
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin ComctlLib.StatusBar ssbar 
      Align           =   2  'Align Bottom
      Height          =   165
      Left            =   0
      TabIndex        =   22
      Top             =   8010
      Width           =   11910
      _ExtentX        =   21008
      _ExtentY        =   291
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   2
            Bevel           =   2
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin ComctlLib.ProgressBar spbar 
      Align           =   2  'Align Bottom
      Height          =   210
      Left            =   0
      TabIndex        =   21
      Top             =   7800
      Width           =   11910
      _ExtentX        =   21008
      _ExtentY        =   370
      _Version        =   327682
      Appearance      =   1
   End
   Begin VB.CommandButton csolve 
      BackColor       =   &H80000004&
      Caption         =   "Sol&ve"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   9000
      Style           =   1  'Graphical
      TabIndex        =   19
      ToolTipText     =   "Solves the current problem"
      Top             =   7275
      Width           =   1305
   End
   Begin VB.CommandButton cexit 
      BackColor       =   &H80000004&
      Caption         =   "&Back"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   10320
      Style           =   1  'Graphical
      TabIndex        =   20
      ToolTipText     =   "Exit to main menu"
      Top             =   7275
      Width           =   1305
   End
   Begin VB.ComboBox combtmp 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   16
      Top             =   240
      Width           =   735
   End
   Begin VB.TextBox ttmp 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
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
      Left            =   120
      MaxLength       =   12
      TabIndex        =   15
      ToolTipText     =   "Enter a real or rational number"
      Top             =   600
      Width           =   615
   End
   Begin VB.CommandButton cok 
      BackColor       =   &H80000004&
      Caption         =   "&Save"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   6360
      Style           =   1  'Graphical
      TabIndex        =   17
      ToolTipText     =   "Save the problem."
      Top             =   7275
      Width           =   1305
   End
   Begin VB.CommandButton cancel 
      BackColor       =   &H80000004&
      Caption         =   "C&ancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   7680
      Style           =   1  'Graphical
      TabIndex        =   18
      ToolTipText     =   "Refresh the form to the initial state."
      Top             =   7275
      Width           =   1305
   End
   Begin VB.Frame fdcon 
      BackColor       =   &H80000004&
      Caption         =   "Details of Constraints"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4095
      Left            =   120
      TabIndex        =   13
      ToolTipText     =   "Constraint specification, ex:3x1+4x2<=5."
      Top             =   3120
      Width           =   11775
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gdcon 
         Height          =   3735
         Left            =   180
         TabIndex        =   14
         ToolTipText     =   "Cell movement keys('U','D','R','L','ENTER')"
         Top             =   285
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   6588
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridLines       =   3
         BorderStyle     =   0
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
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
         _Band(0).TextStyleBand=   0
      End
   End
   Begin VB.Frame fdobj 
      BackColor       =   &H80000004&
      Caption         =   "Details of Objective function"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   120
      TabIndex        =   11
      ToolTipText     =   "Objective function, ex:MAX(Z)=3x1+2x2."
      Top             =   1800
      Width           =   11775
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gdobj 
         Height          =   855
         Left            =   150
         TabIndex        =   12
         ToolTipText     =   "Cell movement keys('U','D','R','L','ENTER')"
         Top             =   255
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   1508
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483644
         HighLight       =   2
         GridLines       =   3
         BorderStyle     =   0
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
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
         _Band(0).TextStyleBand=   0
      End
   End
   Begin VB.Frame fcon 
      BackColor       =   &H80000004&
      Caption         =   "Number of constraints"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   810
      Left            =   6300
      TabIndex        =   7
      ToolTipText     =   "Number of constraints in the Lpp."
      Top             =   900
      Width           =   5595
      Begin VB.CommandButton dec 
         BackColor       =   &H80000004&
         Caption         =   "D&ecrement"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   4050
         Style           =   1  'Graphical
         TabIndex        =   10
         ToolTipText     =   "Decrement number of Constriants by 1. "
         Top             =   240
         Width           =   1440
      End
      Begin VB.CommandButton inc 
         BackColor       =   &H80000004&
         Caption         =   "In&crement"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   2595
         Style           =   1  'Graphical
         TabIndex        =   9
         ToolTipText     =   "Increment number of Constriants by 1. "
         Top             =   240
         Width           =   1440
      End
      Begin VB.TextBox tcon 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   390
         Left            =   120
         MaxLength       =   2
         TabIndex        =   8
         ToolTipText     =   "Number of constraints in the Lpp."
         Top             =   240
         Width           =   2415
      End
   End
   Begin VB.Frame fvar 
      BackColor       =   &H80000004&
      Caption         =   "Number of variables"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   795
      Left            =   120
      TabIndex        =   3
      ToolTipText     =   "Number of variables in LPP, ie x1,x2.."
      Top             =   900
      Width           =   5070
      Begin VB.CommandButton vdec 
         BackColor       =   &H80000004&
         Caption         =   "&Decrement"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   3735
         Style           =   1  'Graphical
         TabIndex        =   6
         ToolTipText     =   "Decrement number of variables by 1. "
         Top             =   255
         Width           =   1260
      End
      Begin VB.CommandButton vinc 
         BackColor       =   &H80000004&
         Caption         =   "&Increment"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   2460
         Style           =   1  'Graphical
         TabIndex        =   5
         ToolTipText     =   "Increment number of variables by 1. "
         Top             =   255
         Width           =   1260
      End
      Begin VB.TextBox tvar 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   120
         MaxLength       =   2
         TabIndex        =   4
         ToolTipText     =   "Number of variables in LPP, ie x1,x2.."
         Top             =   240
         Width           =   2295
      End
   End
   Begin VB.Frame ftype 
      BackColor       =   &H80000004&
      Caption         =   "Objective Type"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   4560
      TabIndex        =   0
      ToolTipText     =   "Specify whether the problem is of MIN or MAX type."
      Top             =   120
      Width           =   2895
      Begin VB.OptionButton opmi 
         BackColor       =   &H80000004&
         Caption         =   "Mi&nimize"
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
         Left            =   1440
         TabIndex        =   2
         ToolTipText     =   "Minimization Lpp."
         Top             =   360
         Width           =   1335
      End
      Begin VB.OptionButton opma 
         BackColor       =   &H80000004&
         Caption         =   "Ma&ximize"
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
         Left            =   120
         TabIndex        =   1
         ToolTipText     =   "Maximization Lpp."
         Top             =   360
         Width           =   1455
      End
   End
End
Attribute VB_Name = "lppeditor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public lppedit As Boolean
Public lpp_id As Long
Dim cur_grid As Integer
Dim obj_x As Integer
Dim obj_y As Integer
Dim cflg As Boolean
Dim con_x As Integer
Dim con_y As Integer
Dim txtflg As Boolean
Dim tmpflg As Boolean
Dim tranflg As Boolean
Dim backuptext As String
Dim reflg As Boolean
Dim finalvalid As Boolean


Public Sub disable_all()
On Error GoTo xit
Dim i As Integer

    For i = 0 To Me.Count - 1 Step 1
        Me.Controls(i).Enabled = False
    Next i
    
    combtmp.clear
    combtmp.AddItem ("<=")
    combtmp.ItemData(combtmp.NewIndex) = 0
    combtmp.AddItem (">=")
    combtmp.ItemData(combtmp.NewIndex) = 1
    combtmp.AddItem ("=")
    combtmp.ItemData(combtmp.NewIndex) = 2
    ftype.Enabled = True
    opma.Enabled = True
    opmi.Enabled = True
    fvar.Enabled = True
    fcon.Enabled = True
    tvar.Enabled = True
    tcon.Enabled = True
    combtmp.Visible = False
    ttmp.Visible = False
    initialize_grids (False)
    
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub cancel_Click()
On Error GoTo xit
    tcon = ""
    tvar = ""
    Call Form_load
Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub cexit_Click()
 Unload Me
End Sub

Private Sub combtmp_Click()
On Error GoTo xit
    If cur_grid = 0 And combtmp.ListIndex <> -1 And Not cflg Then
            gdcon.TextMatrix(con_x, con_y) = combtmp.List(combtmp.ListIndex)
            combtmp.Visible = False
            gdcon.row = con_x
            gdcon.col = con_y + 1
            Call gdcon_Click
    End If
cflg = False
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub combtmp_GotFocus()
With gdcon
combtmp.ListIndex = IIf(.TextMatrix(.row, .col) = "<=", 0, IIf(.TextMatrix(.row, .col) = ">=", 1, 2))
End With
End Sub


Private Sub combtmp_Keydown(pKey As Integer, Shift As Integer)
   
   If Not (pKey = 82 Or pKey = 13 Or pKey = 76 Or pKey = 85 Or pKey = 68) Then
        cflg = True
        Exit Sub
   End If
   cflg = False
   If combtmp.ListIndex <> -1 Then
        gdcon.TextMatrix(con_x, con_y) = combtmp.List(combtmp.ListIndex)
   End If
   If pKey = 82 Or pKey = 13 Then
        gdcon.row = con_x
        gdcon.col = con_y + 1
        ttmp = ""
        Call gdcon_Click
   End If
   If pKey = 76 Then
       gdcon.row = con_x
       gdcon.col = con_y - 1
       ttmp = ""
       Call gdcon_Click
   End If
   If pKey = 85 And con_x > 1 Then
        gdcon.row = con_x - 1
        gdcon.col = con_y
        ttmp = ""
        Call gdcon_Click
   End If
   If pKey = 68 And con_x < gdcon.rows - 1 Then
        gdcon.row = con_x + 1
        gdcon.col = con_y
        ttmp = ""
        Call gdcon_Click
   End If
   pKey = 0
End Sub


Private Sub csolve_Click()
    tmpflg = True
    Call cok_Click
    If reflg Then Exit Sub
    foptions.istransaction = tranflg
    foptions.tmpid = lpp_id
    foptions.psection = "LPP"
    foptions.psubsection = IIf(Val(tvar) = 2, "LPP2", "LPPN2")
    foptions.Show
    Unload Me
End Sub


Private Sub dec_Click()
On Error GoTo xit
If Val(tvar.Text) > 0 And Val(tcon) >= 2 Then
    tcon = tcon - 1
End If
Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub Form_load()
On Error GoTo xit
Dim Y As New Recordset
Dim y1 As New Recordset
Dim i As Integer

    Call disable_all
    spbar.Visible = False
    ssbar.Visible = False
    txtflg = False
    csolve.Visible = True
    cok.Visible = True
    cexit.Visible = True
    cancel.Visible = True
    csolve.Enabled = False
    cok.Enabled = False
    cancel.Enabled = False
    cexit.Enabled = True
    
    cflg = False
    tmpflg = False
    If lppedit = True Then
        Call connect
        Set Y = dn.cn.Execute("select n,m from lpp_main where pid=" & lpp_id & "")
        tvar = Val(Y.Fields("n"))
        tcon = Val(Y.Fields("m"))
        Set Y = dn.cn.Execute("select e_type from lpp_sub1 where(pid=" & lpp_id & " and coid=0)")
        If Y.Fields("e_type") = "MA" Then
            opma.Value = True
            opmi.Value = False
        Else
            opmi.Value = True
            opma.Value = False
        End If
        Call initialize_grids(True)
        Set Y = dn.cn.Execute("select v_value from lpp_sub2 where(pid=" & lpp_id & " and coid=0) order by v_order")
        Y.MoveFirst
        For i = 1 To gdobj.cols - 1 Step 1
            gdobj.TextMatrix(1, i) = Y.Fields("v_value")
            Y.MoveNext
        Next i
        Set Y = dn.cn.Execute("select coid,e_type from lpp_sub1 where(pid=" & lpp_id & " and coid<>0) order by coid")
        Y.MoveFirst
        While Not Y.EOF
            Set y1 = dn.cn.Execute("select v_value,v_order from lpp_sub2 where(pid=" & lpp_id & " and coid=" & Y.Fields("coid") & ") order by v_order")
            y1.MoveFirst
            While Not y1.EOF
                If Val(y1.Fields("v_order")) > Val(tvar) Then
                    If Y.Fields("e_type") = "LE" Then
                        gdcon.TextMatrix(Y.Fields("coid"), y1.Fields("v_order")) = "<="
                    Else
                        If Y.Fields("e_type") = "GE" Then
                            gdcon.TextMatrix(Y.Fields("coid"), y1.Fields("v_order")) = ">="
                        Else
                            gdcon.TextMatrix(Y.Fields("coid"), y1.Fields("v_order")) = "="
                        End If
                    End If
                    gdcon.TextMatrix(Y.Fields("coid"), y1.Fields("v_order") + 1) = y1.Fields("v_value")
                Else
                    gdcon.TextMatrix(Y.Fields("coid"), y1.Fields("v_order")) = y1.Fields("v_value")
                End If
                y1.MoveNext
            Wend
        Y.MoveNext
        Wend
    End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Public Sub text_check_no(txt As TextBox, pKey As Integer, minus As Boolean, dot As Boolean)
Dim i As Integer
Dim tmp As String
       
       If pKey = vbKeyBack Then Exit Sub
       If pKey = 13 Then Exit Sub
       
       If Not (pKey >= 48 And pKey <= 57) Then
            If IIf(dot And Chr$(pKey) = ".", True, False) = True Or IIf(minus = True And Chr$(pKey) = "-", True, False) = True Or Chr$(pKey) = "+" Then
                tmp = Chr$(pKey)
                
                If tmp = "+" Or tmp = "-" Then
                    If Len(txt.Text) > 0 Then
                        pKey = 0
                    End If
                Exit Sub
                End If
                
                For i = 1 To Len(txt) Step 1
                    If Mid(txt.Text, i, 1) = tmp Then
                        pKey = 0
                        Exit Sub
                    End If
                 Next i
                 pKey = pKey
             Else
                 pKey = 0
             End If
        End If
End Sub

Private Sub Form_Unload(cancel As Integer)
    If Not tmpflg Then
        or_form1.Show
    End If
End Sub

Private Sub gdcon_Click()
With gdcon
If .row > 0 And .col > 0 And .row <= .rows - 1 And .col <= .cols - 1 Then
If Me.Visible Then
    cur_grid = 0
    If Not gdcon.col = Val(tvar) + 1 Then
        ttmp = ""
        ttmp.Move gdcon.left + fdcon.left + gdcon.CellLeft, gdcon.Top + fdcon.Top + gdcon.CellTop, gdcon.CellWidth, gdcon.CellHeight
        combtmp.Visible = False
        ttmp.Visible = True
        ttmp.Enabled = True
        ttmp.SetFocus
        ttmp.Text = gdcon.TextMatrix(gdcon.row, gdcon.col)
    Else
        combtmp.Move gdcon.left + fdcon.left + gdcon.CellLeft, gdcon.Top + fdcon.Top + gdcon.CellTop, gdcon.CellWidth
        cflg = True
        combtmp.ListIndex = IIf(.TextMatrix(.row, .col) = "<=", 0, IIf(.TextMatrix(.row, .col) = ">=", 1, 2))
        cflg = False
        ttmp.Visible = False
        combtmp.Enabled = True
        combtmp.Visible = True
        combtmp.SetFocus
    End If
    con_x = gdcon.row
    con_y = gdcon.col
End If
End If
End With
End Sub

Private Sub gdcon_GotFocus()
Dim t As rat
Dim x As Double
Dim Y As Double

If Me.Visible Then
If (cur_grid = 0 And con_x >= 1 And con_y >= 1) Or (cur_grid = 1 And obj_x >= 1 And obj_y >= 1) Then
    If ttmp.Visible And ttmp.Text <> "" Then
        If Not rat_validtext(ttmp) Then
            MsgBox "INVALID RATIONAL NUMBER", vbOKOnly, "OpTech"
            finalvalid = False
            Exit Sub
            ttmp = "0"
        End If
        t = string_rat(ttmp)
        x = t.a
        Y = t.b
        If x / Y > 9000000 Then
                MsgBox "Too large number", vbOKOnly, "ERROR"
                finalvalid = False
                Exit Sub
                x = 0
                Y = 1
        End If
        If cur_grid = 0 Then
            gdcon.TextMatrix(con_x, con_y) = Round(x / Y, 8)
        Else
            gdobj.TextMatrix(obj_x, obj_y) = Round(x / Y, 8)
        End If
    ttmp = ""
    txtflg = False
    ttmp.Visible = False
    ElseIf combtmp.Visible = True And combtmp.ListIndex <> -1 Then
           If cur_grid = 0 And combtmp.ListIndex <> -1 Then
                gdcon.TextMatrix(con_x, con_y) = combtmp.List(combtmp.ListIndex)
           End If
    End If
End If
End If

    If (con_x <= 0 Or con_y <= 0) Then 'And (gdcon.row <= 0 Or gdcon.col <= 0 Or gdcon.row >= gdcon.rows Or gdcon.col >= gdcon.cols) Then
        gdcon.row = 1
        gdcon.col = 1
    End If
    obj_x = 0
    obj_y = 0
    cur_grid = 0
    Call gdcon_Click
End Sub



Private Sub gdobj_GotFocus()
Dim t As rat
Dim x As Double
Dim Y As Double
If Me.Visible Then
If (cur_grid = 0 And con_x >= 1 And con_y >= 1) Or (cur_grid = 1 And obj_x >= 1 And obj_y >= 1) Then
       If ttmp.Visible And ttmp.Text <> "" Then
        If Not rat_validtext(ttmp) Then
            MsgBox "INVALID RATIONAL NUMBER", vbOKOnly, "OpTech"
            finalvalid = False
            Exit Sub
            ttmp = "0"
        End If
        t = string_rat(ttmp)
        x = t.a
        Y = t.b
        If x / Y > 5000 Then
                MsgBox "Too large number", vbOKOnly, "ERROR"
                finalvalid = False
                Exit Sub
                x = 0
                Y = 1
        End If
        If cur_grid = 0 Then
            gdcon.TextMatrix(con_x, con_y) = Round(x / Y, 8)
        Else
            gdobj.TextMatrix(obj_x, obj_y) = Round(x / Y, 8)
        End If
    ttmp = ""
    txtflg = False
    ElseIf combtmp.Visible = True And combtmp.ListIndex <> -1 Then
           If cur_grid = 0 And combtmp.ListIndex <> -1 Then
                gdcon.TextMatrix(con_x, con_y) = combtmp.List(combtmp.ListIndex)
           End If
    End If
End If
End If
  If (obj_x <= 0 Or obj_y <= 0) Then 'And (gdobj.row <= 0 Or gdobj.col <= 0 Or gdobj.row >= gdobj.rows Or gdobj.col >= gdobj.cols) Then
        gdobj.row = 1
        gdobj.col = 1
  End If
  con_x = 0
  con_y = 0
  cur_grid = 1
  Call gdobj_Click
End Sub


Private Sub opma_Click()
    gdobj.TextMatrix(1, 0) = "MAX Z="
End Sub

Private Sub opmi_Click()
    gdobj.TextMatrix(1, 0) = "MIN Z="
End Sub



Private Sub ttmp_KeyPress(pKey As Integer)
On Error GoTo xit
Dim t As rat
Dim x As Double
Dim Y As Double
Dim t1 As String
    
    If pKey = vbKeyBack Then
        Exit Sub
    End If
    t1 = Chr(pKey)
    If pKey = 13 Or t1 = "D" Or t1 = "d" Or t1 = "u" Or t1 = "U" Or t1 = "L" Or t1 = "l" Or t1 = "R" Or t1 = "r" Then
        t1 = UCase(t1)
        pKey = Asc(t1)
        If ttmp <> "" Then
            If Not rat_validtext(ttmp) Then
                MsgBox "INVALID RATIONAL NUMBER", vbOKOnly, "OpTech"
                finalvalid = False
                Exit Sub
                ttmp = "0"
            End If
            t = string_rat(ttmp)
            x = t.a
            Y = t.b
            If (x / Y) > 9000000 Then
                    MsgBox "Too large number", vbOKOnly, "ERROR"
                    finalvalid = False
                    Exit Sub
                    x = 0
                    Y = 1
            End If
            If cur_grid = 0 Then
                gdcon.TextMatrix(con_x, con_y) = Round(x / Y, 8)
            Else
                gdobj.TextMatrix(obj_x, obj_y) = Round(x / Y, 8)
            End If
        Else
            If cur_grid = 0 Then
                gdcon.TextMatrix(con_x, con_y) = ""
            Else
                gdobj.TextMatrix(obj_x, obj_y) = ""
            End If
        End If
        ttmp = ""
        txtflg = False
        ttmp.Visible = False
        If pKey = 82 Or pKey = 13 Then
            If cur_grid = 1 Then
                If Not obj_y = gdobj.cols - 1 Then
                    gdobj.row = obj_x
                    gdobj.col = obj_y + 1
                    ttmp = ""
                    Call gdobj_Click
                Else
                    If obj_x = gdobj.rows - 1 Then
                        cur_grid = 0
                        gdcon.row = 1
                        gdcon.col = 1
                        Call gdcon_Click
                    End If
                End If
            Else
                If Not con_y = gdcon.cols - 1 Then
                    gdcon.row = con_x
                    gdcon.col = con_y + 1
                    ttmp = ""
                    Call gdcon_Click
                Else
                    If con_x = gdcon.rows - 1 Then
                         cok.SetFocus
                    Else
                        gdcon.row = con_x + 1
                        gdcon.col = 1
                        ttmp = ""
                        Call gdcon_Click
                    End If
                End If
            End If
        End If
       If pKey = 76 Then
          If cur_grid = 1 Then
            If Not obj_y <= 1 Then
                gdobj.row = obj_x
                gdobj.col = obj_y - 1
                ttmp = ""
                Call gdobj_Click
             Else
                ttmp = ""
                ttmp.Visible = False
                tcon.SetFocus
             End If
        Else
            If Not con_y <= 1 Then
                gdcon.row = con_x
                gdcon.col = con_y - 1
                ttmp = ""
                Call gdcon_Click
            Else
                If con_x <= 1 Then
                    gdobj.row = gdobj.rows - 1
                    gdobj.col = gdobj.cols - 1
                    ttmp = ""
                    Call gdobj_Click
                Else
                    gdcon.row = con_x - 1
                    gdcon.col = gdcon.cols - 1
                    ttmp = ""
                    Call gdcon_Click
                End If
            End If
        End If
        End If
        If pKey = 68 Then
          If cur_grid = 1 Then
            If Not obj_x >= gdobj.rows - 1 Then
                gdobj.row = obj_x + 1
                gdobj.col = obj_y
                ttmp = ""
                Call gdobj_Click
            End If
        Else
            If Not con_x >= gdcon.rows - 1 Then
                gdcon.row = con_x + 1
                gdcon.col = con_y
                ttmp = ""
                Call gdcon_Click
            End If
        End If
        End If
        If pKey = 85 Then
            If cur_grid = 1 Then
              If Not obj_x <= 1 Then
                gdobj.row = obj_x - 1
                gdobj.col = obj_y
                ttmp = ""
                Call gdobj_Click
            End If
        Else
            If Not con_x <= 1 Then
                gdcon.row = con_x - 1
                gdcon.col = con_y
                ttmp = ""
                Call gdcon_Click
            End If
        End If
        End If
        pKey = 0
        Exit Sub
    End If

    t1 = Chr(pKey)
    If Not (t1 = "+" Or t1 = "-" Or t1 = "/" Or t1 = "." Or (pKey >= 48 And pKey <= 57)) Then
         pKey = 0
    Else
        backuptext = Trim(ttmp.Text)
    End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub ttmp_Change()
    If Not rat_validsubtext(ttmp) Then
        ttmp = backuptext
        SendKeys "{END}", True
        If ttmp = "" Then txtflg = False
    Else
        txtflg = True
    End If
End Sub


Private Sub gdobj_Click()
With gdobj
If .row > 0 And .col > 0 And .row <= .rows - 1 And .col <= .cols - 1 Then
   
    cur_grid = 1
    ttmp = ""
    ttmp.Move gdobj.left + fdobj.left + gdobj.CellLeft, gdobj.Top + fdobj.Top + gdobj.CellTop, gdobj.CellWidth, gdobj.CellHeight
    ttmp.Visible = True
    ttmp.Enabled = True
    ttmp.SetFocus
    obj_x = gdobj.row
    obj_y = gdobj.col
    ttmp.Text = gdobj.TextMatrix(gdobj.row, gdobj.col)
End If

End With
End Sub

Private Sub inc_Click()
On Error GoTo xit
If Val(tvar.Text) > 0 Then
    tcon = tcon + 1
End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub tcon_Change()
On Error GoTo xit
    ttmp.Visible = False
    combtmp.Visible = False
    If Val(tcon) > 50 Then
        MsgBox "You can't enter a number greater than 50 here!!!", vbOKOnly, "Value cannot be accepted"
        tcon = ""
        initialize_grids (False)
        tcon.SetFocus
        Exit Sub
    End If
    If Val(tcon.Text) > 0 And Val(tvar.Text) > 0 Then
        inc.Enabled = True
        If Val(tcon) > 1 Then
            dec.Enabled = True
        Else
            dec.Enabled = False
        End If

            vinc.Enabled = True
            If Val(tvar) > 1 Then
                vdec.Enabled = True
            Else
                vdec.Enabled = False
            End If
        initialize_grids (True)
        
    Else
        initialize_grids (False)
        inc.Enabled = False
        dec.Enabled = False
        vinc.Enabled = False
        vdec.Enabled = False
     
    End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub tcon_KeyPress(pKey As Integer)
On Error GoTo xit
   If pKey = 13 Then
     If gdobj.Enabled Then
        gdobj.SetFocus
     ElseIf fvar.Enabled Then
        tvar.SetFocus
     End If
     Exit Sub
   End If
     Call text_check_no(tcon, pKey, False, False)
Exit Sub
xit:
    Call error_me(Me)
End Sub



Private Sub tvar_Change()
On Error GoTo xit
    ttmp.Visible = False
    combtmp.Visible = False
    If Val(tvar) > 50 Then
        MsgBox "You can't enter a number greater than 50 here!!!", vbOKOnly, "Value cannot be accepted"
        tvar = ""
        initialize_grids (False)
        tvar.SetFocus
        Exit Sub
    End If
    If Val(tcon.Text) > 0 And Val(tvar.Text) > 0 Then
        inc.Enabled = True
        If Val(tcon) > 1 Then
            dec.Enabled = True
        Else
            dec.Enabled = False
        End If

            vinc.Enabled = True
            If Val(tvar) > 1 Then
                vdec.Enabled = True
            Else
                vdec.Enabled = False
            End If
           initialize_grids (True)
        
    Else
        initialize_grids (False)
        inc.Enabled = False
        dec.Enabled = False
        vinc.Enabled = False
        vdec.Enabled = False
    End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub tvar_KeyPress(pKey As Integer)
On Error GoTo xit
    If pKey = 13 Then
        If fcon.Enabled = True Then
            tcon.SetFocus
        Else
            If gdobj.Enabled Then gdobj.SetFocus
        End If
        Exit Sub
    End If
    Call text_check_no(tvar, pKey, False, False)
Exit Sub
xit:
    Call error_me(Me)
End Sub

Public Sub initialize_grids(g_set As Boolean)
On Error GoTo xit
Dim i As Integer
Dim tflg As Integer
Dim oldc As Integer
    
    cok.Visible = True
    cok.Enabled = g_set
    cancel.Visible = True
    cancel.Enabled = g_set
    csolve.Visible = True
    csolve.Enabled = g_set
    
    fdobj.Enabled = g_set
    fdcon.Enabled = g_set
    gdobj.Enabled = g_set
    gdcon.Enabled = g_set
    
    If g_set = False Then
        gdobj.clear
        gdcon.clear
        gdobj.rows = 2
        gdobj.cols = 2
        gdcon.rows = 2
        gdcon.cols = 2
        Exit Sub
    End If
    
    gdobj.rows = 2
    gdobj.cols = Val(tvar) + 1
    gdcon.rows = Val(tcon) + 1
    
    tflg = 0
    If gdcon.cols >= 4 Then
        If gdcon.cols < Val(tvar) + 3 Then
             tflg = 2
        Else
            tflg = 1
        End If
        oldc = gdcon.cols - 2
    End If
    
     
    If tflg = 1 Then
        For i = 1 To gdcon.rows - 1 Step 1
                gdcon.TextMatrix(i, (Val(tvar) + 3) - 2) = gdcon.TextMatrix(i, oldc)
                If oldc <> (Val(tvar) + 3) - 2 Then gdcon.TextMatrix(i, oldc) = ""
                gdcon.TextMatrix(i, (Val(tvar) + 3) - 1) = gdcon.TextMatrix(i, oldc + 1)
        Next i
    End If
    
   
    gdcon.cols = Val(tvar) + 3
    gdobj.FixedCols = 1
    gdobj.FixedRows = 1
    gdcon.FixedCols = 1
    gdcon.FixedRows = 1
    gdobj.TextMatrix(1, 0) = IIf(opmi.Value = True, "MIN", "MAX") & " Z="
   
      
    If tflg = 0 Then
        For i = 1 To gdcon.rows - 1 Step 1
            If gdcon.TextMatrix(i, Val(tvar) + 1) = "" Then
                gdcon.TextMatrix(i, Val(tvar) + 1) = "<="
            End If
        Next i
    End If
   
   If tflg = 2 Then
        For i = 1 To gdcon.rows - 1 Step 1
                gdcon.TextMatrix(i, gdcon.cols - 1) = gdcon.TextMatrix(i, oldc + 1)
                gdcon.TextMatrix(i, gdcon.cols - 2) = gdcon.TextMatrix(i, oldc)
                If oldc <> gdcon.cols - 2 Then gdcon.TextMatrix(i, oldc) = ""
        Next i
    End If
    
    
    For i = 1 To gdobj.cols - 1 Step 1
        gdobj.TextMatrix(0, i) = "X" & Trim(str(i))
        gdcon.TextMatrix(0, i) = "X" & Trim(str(i))
    Next i
    
    For i = 1 To gdcon.rows - 1 Step 1
        gdcon.TextMatrix(i, 0) = "Con" & Trim(str(i))
    Next i
    
    gdcon.TextMatrix(0, Val(tvar) + 1) = "EQ-TYPE"
    
   
    gdcon.TextMatrix(0, Val(tvar) + 2) = "VALUE"
    
    For i = 0 To gdobj.cols - 1 Step 1
        gdobj.ColWidth(i) = 1320
    Next i
    For i = 0 To gdcon.cols - 1 Step 1
        gdcon.ColWidth(i) = 1320
    Next i
    
    cur_grid = 1
    con_x = 0
    con_y = 0
    obj_x = 0
    obj_y = 0
    ttmp = ""
    
Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub cok_Click()
On Error GoTo xit
Dim tmp As Boolean
Dim max_pid As Long
Dim max_coid As Long
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim l As Long
Dim xtraflg As Boolean
Dim optval As Long

reflg = True
finalvalid = True
If ttmp.Visible And ttmp.Text <> "" Then Call ttmp_KeyPress(13)
If Not finalvalid Then
    ttmp.SetFocus
    Exit Sub
End If

Call connect
dn.cn.BeginTrans

If Val(tvar) > 50 Or Val(tcon) > 50 Then
    MsgBox "You can't enter number of variables or number of constraints greater than 50." & vbCrLf & "Reduce them & retry.", vbOKOnly, "ERROR!!!"
    Exit Sub
End If

tmp = lppedit
tranflg = False
l = MsgBox(IIf(lppedit, IIf(tmpflg, "Do you like to ", "") + "Overwrite existing problem?" + vbCrLf + vbCrLf + "Yes:for overwriting." + vbCrLf + "No:for save the problem as a new problem." + vbCrLf + IIf(tmpflg, "Cancel:Proceed without saving.", "Cancel:for abort save option."), "Save the problem" + IIf(tmpflg, " before proceeding?", "?")), IIf(lppedit, vbYesNoCancel, vbOKCancel), IIf(lppedit, "Overwrite confirm!!!", "Save Confirm!!!"))
If l = vbCancel Then
    If Not tmpflg Then
        Exit Sub
    Else
        tranflg = True
    End If
ElseIf l = vbNo Then
    lppedit = False
End If

ssbar.Visible = True
spbar.Visible = True
spbar.max = Val(tvar) + Val(tcon) * (Val(tvar) + 2)
spbar.min = 0

spbar.Value = 0
ssbar.Panels(1).Text = "Validating problem entry, Please wait"
If lppedit = False Then
    max_pid = getmaxid("pid", "lpp_main", -1, False)
Else
    max_pid = lpp_id
    dn.cn.Execute "delete from lpp_sub2 where pid=" & lpp_id
    dn.cn.Execute "delete from lpp_sub1 where pid=" & lpp_id
    dn.cn.Execute "delete from lpp_main where pid=" & lpp_id
End If

dn.cn.Execute "insert into lpp_main(pid,n,m) values(" & max_pid & "," & Val(tvar) & "," & Val(tcon) & ")"
dn.cn.Execute "insert into lpp_sub1(pid,o_c,e_type,coid) values" & _
           "(" & max_pid & ",'O','" & IIf(opmi.Value = True, "MI", "MA") & "',0)"
           
xtraflg = False
For i = 1 To gdobj.cols - 1 Step 1
   If Not xtraflg And gdobj.TextMatrix(1, i) = "" Then
        optval = MsgBox("No value entered for variable X" + Trim(str(i)) + " for the Objective function." + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
        If optval = vbNo Then
            gdobj.row = 1
            gdobj.col = i
            Call gdobj_Click
            dn.cn.RollbackTrans
            spbar.Visible = False
            ssbar.Visible = False
            Exit Sub
        ElseIf optval = vbCancel Then
            xtraflg = True
        Else
            xtraflg = False
        End If
    End If
    dn.cn.Execute "insert into lpp_sub2(pid,coid,v_order,v_value) values" & _
    "(" & max_pid & ",0," & i & "," & Val(gdobj.TextMatrix(1, i)) & ")"
    spbar.Value = IIf(spbar.Value + 1 < spbar.max, spbar.Value + 1, spbar.max)
Next i

For i = 1 To gdcon.rows - 1 Step 1
   If Not xtraflg And gdcon.TextMatrix(i, gdcon.cols - 1) = "" Then
        optval = MsgBox("No value entered for the limit of the constraint" + Trim(str(i)) + "." + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
        If optval = vbNo Then
            gdcon.row = i
            gdcon.col = gdcon.cols - 1
            Call gdcon_Click
            dn.cn.RollbackTrans
            spbar.Visible = False
            ssbar.Visible = False
            Exit Sub
        ElseIf optval = vbCancel Then
            xtraflg = True
        Else
            xtraflg = False
        End If
    End If
 
 If Val(gdcon.TextMatrix(i, gdcon.cols - 1)) < 0 Then
    For j = 1 To gdcon.cols - 1 Step 1
        If j <> gdcon.cols - 2 Then
            gdcon.TextMatrix(i, j) = -gdcon.TextMatrix(i, j)
        Else
            gdcon.TextMatrix(i, j) = IIf(gdcon.TextMatrix(i, j) = "=", "=", IIf(gdcon.TextMatrix(i, j) = "<=" _
             , ">=", "<="))
        End If
    Next j
 Else
    If gdcon.TextMatrix(i, gdcon.cols - 2) = "" Then
        gdcon.TextMatrix(i, gdcon.cols - 2) = "<="
    End If
 End If
 

 dn.cn.Execute "insert into lpp_sub1(pid,o_c,e_type,coid) values" & _
  "(" & max_pid & ",'C','" & IIf(gdcon.TextMatrix(i, Val(tvar) + 1) = "=", "EQ", IIf(gdcon.TextMatrix _
  (i, Val(tvar) + 1) = "<=", "LE", "GE")) & "'," & i & ")"
 spbar.Value = IIf(spbar.Value + 1 < spbar.max, spbar.Value + 1, spbar.max)
  k = 1
  For j = 1 To gdcon.cols - 1 Step 1
    If j <> gdcon.cols - 2 Then
        If Not xtraflg And gdcon.TextMatrix(i, j) = "" And j <> gdcon.cols - 1 Then
            If j <> gdcon.cols - 1 Then
                optval = MsgBox("No value entered for the variable X" + Trim(str(j)) + " of the constraint" + Trim(str(i)) + "." + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
            Else
                optval = MsgBox("No value entered for the limit of the constraint" + Trim(str(i)) + "." + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
            End If
            If optval = vbNo Then
                gdcon.row = i
                gdcon.col = j
                Call gdcon_Click
                dn.cn.RollbackTrans
                spbar.Visible = False
                ssbar.Visible = False
                Exit Sub
            ElseIf optval = vbCancel Then
                xtraflg = True
            Else
                xtraflg = False
            End If
        End If
        dn.cn.Execute "insert into lpp_sub2(pid,coid,v_order,v_value) values" & _
        "(" & max_pid & "," & i & "," & k & "," & Val(gdcon.TextMatrix(i, j)) & ")"
        
        k = k + 1
        spbar.Value = IIf(spbar.Value + 1 < spbar.max, spbar.Value + 1, spbar.max)
    End If
  Next j
Next i
spbar.Value = spbar.max

If Not tmpflg Then
    dn.cn.CommitTrans
    or_form1.enable_menu_properly (1)
    If Not lppedit Then
        MsgBox "ID provided for your problem is " & str(max_pid), vbOKOnly, "YOUR PROBLEM ID!!!"
    End If
    If tmp Then
        If lppedit Then
            Call or_form1.combopid_Click
        Else
            Call or_form1.combopid.AddItem(Trim(str(max_pid)), or_form1.combopid.ListCount)
        End If
    Else
        or_form1.enable_cntrls (False)
    End If
    Unload Me
    Exit Sub
Else
    If Not tranflg Then
        dn.cn.CommitTrans
        or_form1.enable_menu_properly (1)
        If tmp Then
            If lppedit Then
                Call or_form1.combopid_Click
            Else
                Call or_form1.combopid.AddItem(Trim(str(max_pid)), or_form1.combopid.ListCount)
            End If
        Else
            or_form1.enable_cntrls (False)
        End If
    End If
    lpp_id = max_pid
End If
spbar.Visible = False
ssbar.Visible = False

lppedit = tmp
reflg = False
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub vdec_Click()
On Error GoTo xit
If Val(tcon.Text) > 0 And Val(tvar) >= 2 Then
    tvar = tvar - 1
End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub vinc_Click()
On Error GoTo xit
If Val(tcon.Text) > 0 Then
    tvar = tvar + 1
End If
Exit Sub
xit:
    Call error_me(Me)
End Sub
