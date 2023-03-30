VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form tppeditor 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "TPP EDITOR"
   ClientHeight    =   8160
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9960
   BeginProperty Font 
      Name            =   "Bookman Old Style"
      Size            =   9
      Charset         =   0
      Weight          =   600
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00400000&
   Icon            =   "tppeditor.frx":0000
   LinkTopic       =   "Form1"
   Picture         =   "tppeditor.frx":0442
   ScaleHeight     =   8160
   ScaleWidth      =   9960
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
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
      Left            =   10560
      Style           =   1  'Graphical
      TabIndex        =   19
      ToolTipText     =   "Exit to main menu"
      Top             =   7200
      Width           =   1215
   End
   Begin VB.CommandButton csolve 
      BackColor       =   &H80000004&
      Caption         =   "S&olve"
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
      Left            =   9330
      Style           =   1  'Graphical
      TabIndex        =   16
      ToolTipText     =   "Solves the current problem."
      Top             =   7200
      Width           =   1215
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
      Left            =   2280
      MaxLength       =   12
      TabIndex        =   15
      Top             =   360
      Width           =   615
   End
   Begin VB.CommandButton cok 
      BackColor       =   &H80000004&
      Caption         =   "&save"
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
      Left            =   6870
      Style           =   1  'Graphical
      TabIndex        =   13
      ToolTipText     =   "Saves the problem."
      Top             =   7200
      Width           =   1215
   End
   Begin VB.CommandButton cancel 
      BackColor       =   &H80000004&
      Caption         =   "c&ancel"
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
      Left            =   8100
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "Undo the changes."
      Top             =   7200
      Width           =   1215
   End
   Begin VB.Frame fdcon 
      BackColor       =   &H80000004&
      Caption         =   "TRANSPORTATION    MATRIX"
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
      Height          =   5295
      Left            =   120
      TabIndex        =   11
      ToolTipText     =   $"tppeditor.frx":1A8C
      Top             =   1800
      Width           =   11775
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gdcon 
         Height          =   4935
         Left            =   135
         TabIndex        =   12
         ToolTipText     =   "Cell movement keys('U','D','R','L','ENTER')"
         Top             =   240
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   8705
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
   Begin VB.Frame fcon 
      BackColor       =   &H80000004&
      Caption         =   "NUMBER OF SOURCES"
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
      Height          =   750
      Left            =   128
      TabIndex        =   3
      ToolTipText     =   "Number of Sources in the TP/Number of Machines in the AP."
      Top             =   975
      Width           =   5025
      Begin VB.CommandButton dec 
         BackColor       =   &H80000004&
         Caption         =   "&Decrement"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   3750
         Style           =   1  'Graphical
         TabIndex        =   6
         ToolTipText     =   "Decrement number in the textbox by 1   "
         Top             =   225
         Width           =   1140
      End
      Begin VB.CommandButton inc 
         BackColor       =   &H80000004&
         Caption         =   "&Increment"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   2595
         Style           =   1  'Graphical
         TabIndex        =   5
         ToolTipText     =   "Increment number in the textbox by 1  "
         Top             =   225
         Width           =   1140
      End
      Begin VB.TextBox tcon 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         MaxLength       =   2
         TabIndex        =   4
         ToolTipText     =   "Number of Sources in the TP/Number of Machines in the AP."
         Top             =   240
         Width           =   2415
      End
   End
   Begin VB.Frame fvar 
      BackColor       =   &H80000004&
      Caption         =   "NUMBER OF DESTINATIONS"
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
      Height          =   765
      Left            =   7035
      TabIndex        =   7
      ToolTipText     =   "Number of Destinations in the TP/Number of Jobs in the AP."
      Top             =   960
      Width           =   4860
      Begin VB.CommandButton vdec 
         BackColor       =   &H80000004&
         Caption         =   "D&ecrement"
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
         Left            =   3645
         Style           =   1  'Graphical
         TabIndex        =   10
         ToolTipText     =   "Decrement number in the textbox by 1   "
         Top             =   240
         Width           =   1140
      End
      Begin VB.CommandButton vinc 
         BackColor       =   &H80000004&
         Caption         =   "I&ncrement"
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
         Left            =   2475
         Style           =   1  'Graphical
         TabIndex        =   9
         ToolTipText     =   "Increment number in the textbox by 1  "
         Top             =   240
         Width           =   1140
      End
      Begin VB.TextBox tvar 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   390
         Left            =   120
         MaxLength       =   2
         TabIndex        =   8
         ToolTipText     =   "Number of Destinations in the TP/Number of Jobs in the AP."
         Top             =   240
         Width           =   2295
      End
   End
   Begin VB.Frame ftype 
      BackColor       =   &H80000004&
      Caption         =   "Objective Type"
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
      Height          =   735
      Left            =   4680
      TabIndex        =   0
      ToolTipText     =   "Specify whether the problem is of MIN or MAX type."
      Top             =   120
      Width           =   2775
      Begin VB.OptionButton opmi 
         BackColor       =   &H80000004&
         Caption         =   "Mini&mize"
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
         Height          =   255
         Left            =   1440
         TabIndex        =   2
         ToolTipText     =   "Minimization TP/AP."
         Top             =   360
         Width           =   1155
      End
      Begin VB.OptionButton opma 
         BackColor       =   &H80000004&
         Caption         =   "Maximi&ze"
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
         Height          =   255
         Left            =   120
         TabIndex        =   1
         ToolTipText     =   "Maximization TP/AP."
         Top             =   360
         Width           =   1455
      End
   End
   Begin ComctlLib.StatusBar ssbar 
      Align           =   2  'Align Bottom
      Height          =   225
      Left            =   0
      TabIndex        =   17
      Top             =   7935
      Width           =   9960
      _ExtentX        =   17568
      _ExtentY        =   397
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
      TabIndex        =   18
      Top             =   7725
      Width           =   9960
      _ExtentX        =   17568
      _ExtentY        =   370
      _Version        =   327682
      Appearance      =   1
   End
End
Attribute VB_Name = "tppeditor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public is_tp As Boolean
Public Tppedit As Boolean
Public Tpp_id As Long
Dim con_x As Integer
Dim con_y As Integer
Dim tmpflg As Boolean
Dim tranflg As Boolean
Dim reflg As Boolean
Dim delflg As Boolean
Dim finalvalid As Boolean

Public Sub disable_all()
On Error GoTo xit
Dim i As Integer

    For i = 0 To Me.Count - 1 Step 1
        Me.Controls(i).Enabled = False
    Next i
    
    ftype.Enabled = True
    opma.Enabled = True
    opmi.Enabled = True
    fvar.Enabled = True
    fcon.Enabled = True
    tvar.Enabled = True
    tcon.Enabled = True
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

Private Sub csolve_Click()
    tmpflg = True
    Call cok_Click
    If reflg Then Exit Sub
    foptions.istransaction = tranflg
    foptions.tmpid = Tpp_id
    foptions.psection = IIf(is_tp, "TPP", "AP")
    foptions.Show
    Unload Me
End Sub

Private Sub dec_Click()
On Error GoTo xit
If Val(tvar.Text) > 0 And Val(tcon) >= 2 Then
    delflg = False
    tcon = tcon - 1
End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_load()
On Error GoTo xit
Dim Y As New Recordset
Dim i As Integer

    If is_tp Then
        Me.HelpContextID = 8
    Else
        Me.HelpContextID = 9
    End If
    Call disable_all
    delflg = True
    tmpflg = False
    spbar.Visible = False
    ssbar.Visible = False
    csolve.Visible = True
    cok.Visible = True
    cexit.Visible = True
    cancel.Visible = True
    csolve.Enabled = False
    cok.Enabled = False
    cancel.Enabled = False
    cexit.Enabled = True
    If is_tp Then
        Me.Caption = "TPP editor"
        fcon.Caption = "Number of Sources"
        fcon.ToolTipText = "Specify number of sources"
        tcon.ToolTipText = "Specify number of sources"
        fvar.Caption = "Number of Destinations"
        fvar.ToolTipText = "Specify number of destinations"
        tvar.ToolTipText = "Specify number of destinations"
        fdcon.Caption = "Details of Transportation matrix"
    Else
        Me.Caption = "AP editor"
        fcon.Caption = "Number of Machines"
        fcon.ToolTipText = "Specify number of machines"
        tcon.ToolTipText = "Specify number of machines"
        fvar.Caption = "Number of Jobs"
        fvar.ToolTipText = "Specify number of jobs"
        tvar.ToolTipText = "Specify number of jobs"
        fvar.Enabled = False
        fdcon.Caption = "Details of Assignment matrix"
    End If
    If Tppedit = True Then
        Call connect
        Set Y = dn.cn.Execute("select nsrc,ndst,t_type from tpp_main where tid=" & Tpp_id & "")
        tvar = Val(Y.Fields("ndst"))
        tcon = Val(Y.Fields("nsrc"))
        If Y.Fields("t_type") = "MA" Then
            opma.Value = True
            opmi.Value = False
        Else
            opmi.Value = True
            opma.Value = False
        End If
        Call initialize_grids(True)
        Set Y = dn.cn.Execute("select sdno,recap from tpp_sub1 where(tid=" & Tpp_id & " and sord='S') order by sdno")
        Y.MoveFirst
        For i = 1 To gdcon.rows - 2 Step 1
            gdcon.TextMatrix(i, gdcon.cols - 1) = Y.Fields("recap")
            Y.MoveNext
        Next i
        Set Y = dn.cn.Execute("select sdno,recap from tpp_sub1 where(tid=" & Tpp_id & " and sord='D') order by sdno")
        Y.MoveFirst
        For i = 1 To gdcon.cols - 2 Step 1
            gdcon.TextMatrix(gdcon.rows - 1, i) = Y.Fields("recap")
            Y.MoveNext
        Next i
        
        Set Y = dn.cn.Execute("select srcid,dstid,cost from tpp_sub2 where tid=" & Tpp_id)
        Y.MoveFirst
        While Not Y.EOF
            gdcon.TextMatrix(Y.Fields("srcid"), Y.Fields("dstid")) = Y.Fields("cost")
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
On Error GoTo xit
   With gdcon
   If .row > 0 And .col > 0 And Not (.row = .rows - 1 And .col = .cols - 1) And Not (Not is_tp And (.row = .rows - 1 Or .col = .cols - 1)) Then
   If Me.Visible Then
        ttmp = ""
        ttmp.Move gdcon.left + fdcon.left + gdcon.CellLeft, gdcon.Top + fdcon.Top + gdcon.CellTop, gdcon.CellWidth, gdcon.CellHeight
        ttmp.Visible = True
        ttmp.Enabled = True
        ttmp.SetFocus
        ttmp.Text = gdcon.TextMatrix(gdcon.row, gdcon.col)
    con_x = gdcon.row
    con_y = gdcon.col
  End If
  End If
  End With
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub gdcon_GotFocus()
    If Me.Visible And ttmp.Text <> "" And con_x >= 1 And con_y >= 1 And ttmp.Visible Then
           If Val(ttmp) > 9000000 Then
              MsgBox "Too large number", vbOKOnly, "ERROR"
              finalvalid = False
              Exit Sub
              ttmp = "0"
           End If
           gdcon.TextMatrix(con_x, con_y) = Round(Val(ttmp), 8)
    End If
    
       ttmp = ""
       ttmp.Visible = False
    If con_x <= 0 Or con_y <= 0 Then
        gdcon.row = 1
        gdcon.col = 1
    End If
    Call gdcon_Click
End Sub


Private Sub ttmp_KeyPress(pKey As Integer)
On Error GoTo xit
Dim t1 As String
    
    If pKey = vbKeyBack Then
        Exit Sub
    End If
    
    t1 = Chr(pKey)
    
    If pKey = 13 Or t1 = "D" Or t1 = "d" Or t1 = "u" Or t1 = "U" Or t1 = "L" Or t1 = "l" Or t1 = "R" Or t1 = "r" Then
        If Val(ttmp) > 9000000 Then
              MsgBox "Too large number", vbOKOnly, "ERROR"
              finalvalid = False
              Exit Sub
              ttmp = "0"
        End If
        If ttmp <> "" Then
            gdcon.TextMatrix(con_x, con_y) = Round(Val(ttmp), 8)
        Else
            gdcon.TextMatrix(con_x, con_y) = ""
        End If
        ttmp = ""
        ttmp.Visible = False
        t1 = UCase(t1)
        pKey = Asc(t1)
          
          If pKey = 82 Or pKey = 13 Then
            If Not con_y >= IIf(is_tp, IIf(con_x = gdcon.rows - 1, gdcon.cols - 2, gdcon.cols - 1), IIf(con_x = gdcon.rows - 2, gdcon.cols - 2, gdcon.cols - 2)) Then
                gdcon.row = con_x
                gdcon.col = con_y + 1
                ttmp = ""
                Call gdcon_Click
            Else
                If con_x = IIf(is_tp, gdcon.rows - 1, gdcon.rows - 2) Then
                    ttmp = ""
                    ttmp.Visible = False
                    cok.SetFocus
                Else
                        gdcon.row = con_x + 1
                        gdcon.col = 1
                        ttmp = ""
                        Call gdcon_Click
                End If
            End If
         End If
           
       If pKey = 76 Then
           If Not con_y <= 1 Then
                gdcon.row = con_x
                gdcon.col = con_y - 1
                ttmp = ""
                Call gdcon_Click
            Else
                If con_x <= 1 Then
                    ttmp = ""
                    ttmp.Visible = False
                    tcon.SetFocus
                Else
                    gdcon.row = con_x - 1
                    gdcon.col = IIf(is_tp, gdcon.cols - 1, gdcon.cols - 2)
                    ttmp = ""
                    Call gdcon_Click
                End If
            End If
        End If
     
       If pKey = 68 Then
           If Not con_x >= IIf(is_tp, gdcon.rows - 1, gdcon.rows - 2) Then
                gdcon.row = con_x + 1
                gdcon.col = con_y
                ttmp = ""
                Call gdcon_Click
            End If
       End If
    
    If pKey = 85 Then
            If Not con_x <= 1 Then
                gdcon.row = con_x - 1
                gdcon.col = con_y
                ttmp = ""
                Call gdcon_Click
            End If
    End If
        pKey = 0
        Exit Sub
    End If
    
    
    If con_x = gdcon.rows - 1 Or con_y = gdcon.cols - 1 Then
        Call text_check_no(ttmp, pKey, False, False)
    Else
        Call text_check_no(ttmp, pKey, False, True)
    End If
    
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub inc_Click()
If Val(tvar.Text) > 0 Then
    delflg = False
    tcon = tcon + 1
End If
End Sub

Private Sub opmi_Click()
    'Call tcon_Change
End Sub
Private Sub opma_Click()
   'Call tcon_Change
End Sub

Private Sub tcon_Change()
On Error GoTo xit
Dim tmpflg As Boolean
    
    ttmp.Visible = False
    
    If Val(tcon) > 50 Then
        MsgBox "You can't enter a number greater than 50 here!!!", vbOKOnly, "Value cannot be accepted"
        tcon = ""
        initialize_grids (False)
        tcon.SetFocus
        Exit Sub
    End If
    
    If Not is_tp Then
        tmpflg = delflg
        tvar = Val(tcon)
        delflg = tmpflg
    End If
    
    If Val(tcon.Text) > 0 And Val(tvar.Text) > 0 Then
        inc.Enabled = True
        If Val(tcon) > 1 Then
            dec.Enabled = True
        Else
            dec.Enabled = False
        End If

        If is_tp Then
            vinc.Enabled = True
            If Val(tvar) > 1 Then
                vdec.Enabled = True
            Else
                vdec.Enabled = False
            End If
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
        If fvar.Enabled = True Then
            tvar.SetFocus
        Else
            If gdcon.Enabled Then gdcon.SetFocus
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
    If Val(tvar) > 50 Then
        MsgBox "You can't enter a number greater than 50 here!!!", vbOKOnly, "Value cannot be accepted"
        tvar = ""
        initialize_grids (False)
        If is_tp Then
            tvar.SetFocus
        ElseIf fcon.Enabled Then
            tcon.SetFocus
        End If

        Exit Sub
    End If
    
    If Val(tcon.Text) > 0 And Val(tvar.Text) > 0 Then
        initialize_grids (True)
        inc.Enabled = True
        If Val(tcon) > 1 Then
            dec.Enabled = True
        Else
            dec.Enabled = False
        End If

        If is_tp Then
            vinc.Enabled = True
            If Val(tvar) > 1 Then
                vdec.Enabled = True
            Else
                vdec.Enabled = False
            End If
        End If
        
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
        If gdcon.Enabled Then
            gdcon.SetFocus
        ElseIf fcon.Enabled Then
            tcon.SetFocus
        End If
    End If
    Call text_check_no(tvar, pKey, False, False)
Exit Sub
xit:
    Call error_me(Me)
End Sub

Public Sub initialize_grids(g_set As Boolean)
On Error GoTo xit
Dim i As Integer
Dim j As Integer
    
    cok.Visible = True
    cok.Enabled = g_set
    cancel.Visible = True
    cancel.Enabled = g_set
    fdcon.Enabled = g_set
    gdcon.Enabled = g_set
    csolve.Visible = True
    csolve.Enabled = g_set
    
    If g_set = False Then
        gdcon.clear
        gdcon.rows = 1
        gdcon.cols = 1
        Exit Sub
    End If
    
    gdcon.rows = Val(tcon) + 2
    gdcon.cols = Val(tvar) + 2
    gdcon.FixedCols = 1
    gdcon.FixedRows = 1
        
   If delflg Then
        For i = 0 To gdcon.rows - 1 Step 1
            For j = 0 To gdcon.cols - 1 Step 1
                gdcon.TextMatrix(i, j) = ""
            Next j
        Next i
   End If
   delflg = True
   
   For i = 1 To gdcon.cols - 2 Step 1
       gdcon.TextMatrix(0, i) = IIf(Not is_tp, "JOB", "DST") & Trim(str(i))
       If Not is_tp Then
            gdcon.TextMatrix(gdcon.rows - 2, i) = ""
            gdcon.TextMatrix(gdcon.rows - 1, i) = 1
       End If
    Next i
    
    For i = 1 To gdcon.rows - 2 Step 1
        gdcon.TextMatrix(i, 0) = IIf(Not is_tp, "MACH", "SRC") & Trim(str(i))
        If Not is_tp Then
            gdcon.TextMatrix(i, gdcon.cols - 2) = ""
            gdcon.TextMatrix(i, gdcon.cols - 1) = 1
       End If
    Next i
    
    gdcon.TextMatrix(0, gdcon.cols - 1) = "CAPS"
    gdcon.TextMatrix(gdcon.rows - 1, 0) = "REQS"
    gdcon.TextMatrix(gdcon.rows - 1, gdcon.cols - 1) = ""
    
    For i = 0 To gdcon.cols - 1 Step 1
        gdcon.ColWidth(i) = 1320
    Next i
    con_x = 0
    con_y = 0
    
Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub cok_Click()
On Error GoTo xit
Dim tmp As Boolean
Dim max_tid As Long
Dim i As Integer
Dim j As Integer
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

If Val(tvar) > 50 Or Val(tcon) > 50 Then
    MsgBox "You can't enter number of " & IIf(is_tp, "Sorces", "Machines") + " or number of " + IIf(is_tp, "Destinations", "Jobs") + " greater than 50." & vbCrLf & "Reduce them & retry.", vbOKOnly, "ERROR!!!"
    Exit Sub
End If

Call connect
dn.cn.BeginTrans

tmp = Tppedit
tranflg = False
l = MsgBox(IIf(Tppedit, IIf(tmpflg, "Do you like to ", "") + "Overwrite existing problem?" + vbCrLf + vbCrLf + "Yes:for overwriting." + vbCrLf + "No:for save the problem as a new problem." + vbCrLf + IIf(tmpflg, "Cancel:Proceed without saving.", "Cancel:for abort save option."), "Save the problem" + IIf(tmpflg, " before proceeding?", "?")), IIf(Tppedit, vbYesNoCancel, vbOKCancel), IIf(Tppedit, "Overwrite confirm!!!", "Save Confirm!!!"))
If l = vbCancel Then
    If Not tmpflg Then
        Exit Sub
    Else
        tranflg = True
    End If
ElseIf l = vbNo Then
    Tppedit = False
End If

If Tppedit Then
    If MsgBox("SAVE AS A NEW PROBLEM?", vbYesNo, "SAVE OPTION!!!") = vbYes Then
        Tppedit = False
    End If
End If

ssbar.Visible = True
spbar.Visible = True
spbar.max = gdcon.rows * gdcon.cols
spbar.min = 0
spbar.Value = 0
ssbar.Panels(1).Text = "Validating problem entry, Please wait"

If Tppedit = False Then
    max_tid = getmaxid("tid", "tpp_main", -1, False)
Else
    max_tid = Tpp_id
    dn.cn.Execute "delete from tpp_sub2 where tid=" & max_tid
    dn.cn.Execute "delete from tpp_sub1 where tid=" & max_tid
    dn.cn.Execute "delete from tpp_main where tid=" & max_tid
End If

dn.cn.Execute "insert into tpp_main(tid,nsrc,ndst,t_type,tora) values(" & max_tid & "," & Val(tcon) & "," & Val(tvar) & ",'" & IIf(opmi.Value = True, "MI", "MA") & "','" & IIf(is_tp, "T", "A") & "')"


xtraflg = False
For i = 1 To gdcon.rows - 2 Step 1
        If Not xtraflg And gdcon.TextMatrix(i, gdcon.cols - 1) = "" Then
            optval = MsgBox("No Capacity entered for Source-" + Trim(str(i)) + "." + vbCrLf + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
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
    dn.cn.Execute "insert into tpp_sub1(tid,sdno,recap,sord) values(" & max_tid & "," & i & "," & Val(gdcon.TextMatrix(i, gdcon.cols - 1)) & ",'S')"
    spbar.Value = IIf(spbar.Value + 1 < spbar.max, spbar.Value + 1, spbar.max)
Next i
        
For i = 1 To gdcon.cols - 2 Step 1
        If Not xtraflg And gdcon.TextMatrix(gdcon.rows - 1, i) = "" Then
            optval = MsgBox("No Requirement entered for Destination-" + Trim(str(i)) + "." + vbCrLf + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
            If optval = vbNo Then
                gdcon.row = gdcon.rows - 1
                gdcon.col = i
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
    dn.cn.Execute "insert into tpp_sub1(tid,sdno,recap,sord) values(" & max_tid & "," & i & "," & Val(gdcon.TextMatrix(gdcon.rows - 1, i)) & ",'D')"
    spbar.Value = IIf(spbar.Value + 1 < spbar.max, spbar.Value + 1, spbar.max)
Next i


For i = 1 To gdcon.rows - 2 Step 1
    For j = 1 To gdcon.cols - 2 Step 1
        If Not xtraflg And gdcon.TextMatrix(i, j) = "" Then
            optval = MsgBox("No " + IIf(opma.Value, "Profit", "Cost") + " value entered for " + IIf(is_tp, "Source-", "Machine-") + Trim(str(i)) + "," + IIf(is_tp, "Destination-", "Job-") + Trim(str(j)) + "." + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
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
        dn.cn.Execute "insert into tpp_sub2(tid,srcid,dstid,cost) values(" & max_tid & "," & i & "," & j & "," & Val(gdcon.TextMatrix(i, j)) & ")"
        spbar.Value = IIf(spbar.Value + 1 < spbar.max, spbar.Value + 1, spbar.max)
    Next j
Next i

spbar.Value = spbar.max

If Not tmpflg Then
    dn.cn.CommitTrans
    If is_tp Then
        or_form1.enable_menu_properly (2)
    Else
        or_form1.enable_menu_properly (3)
    End If
    If Not Tppedit Then
        MsgBox "ID provided for your problem is " & str(max_tid), vbOKOnly, "YOUR PROBLEM ID!!!"
    Else
        Call or_form1.combopid_Click
    End If
    If tmp Then
        If Tppedit Then
            Call or_form1.combopid_Click
        Else
            Call or_form1.combopid.AddItem(Trim(str(max_tid)), or_form1.combopid.ListCount)
        End If
    Else
        or_form1.enable_cntrls (False)
    End If
    Unload Me
    Exit Sub
Else
    If Not tranflg Then
        dn.cn.CommitTrans
        If is_tp Then
            or_form1.enable_menu_properly (2)
        Else
            or_form1.enable_menu_properly (3)
        End If
        
        If tmp Then
            If Tppedit Then
                Call or_form1.combopid_Click
            Else
                Call or_form1.combopid.AddItem(Trim(str(max_tid)), or_form1.combopid.ListCount)
            End If
        Else
            or_form1.enable_cntrls (False)
        End If
    End If
    Tpp_id = max_tid
End If

spbar.Visible = False
ssbar.Visible = False
reflg = False

Tppedit = tmp
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub vdec_Click()
If Val(tcon.Text) > 0 And Val(tvar) >= 2 Then
    delflg = False
    tvar = tvar - 1
End If
End Sub

Private Sub vinc_Click()
If Val(tcon.Text) > 0 Then
    delflg = False
    tvar = tvar + 1
End If
End Sub
