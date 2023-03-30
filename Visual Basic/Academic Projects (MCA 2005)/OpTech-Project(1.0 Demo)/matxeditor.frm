VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form matxeditor 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Matrix Editor"
   ClientHeight    =   8025
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11910
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
   HelpContextID   =   13
   Icon            =   "matxeditor.frx":0000
   LinkTopic       =   "Form1"
   Picture         =   "matxeditor.frx":0442
   ScaleHeight     =   8025
   ScaleWidth      =   11910
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin ComctlLib.ProgressBar spbar 
      Align           =   2  'Align Bottom
      Height          =   180
      Left            =   0
      TabIndex        =   16
      Top             =   7680
      Width           =   11910
      _ExtentX        =   21008
      _ExtentY        =   318
      _Version        =   327682
      Appearance      =   0
   End
   Begin VB.CommandButton csolve 
      BackColor       =   &H80000004&
      Caption         =   "Sol&ve"
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
      Left            =   9240
      Style           =   1  'Graphical
      TabIndex        =   13
      ToolTipText     =   "Solves the current problem"
      Top             =   7320
      Width           =   1215
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
      Left            =   10455
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "Exit to main menu"
      Top             =   7320
      Width           =   1215
   End
   Begin VB.TextBox ttmp 
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
      Height          =   375
      Left            =   2880
      MaxLength       =   12
      TabIndex        =   12
      ToolTipText     =   "Enter a real or rational number"
      Top             =   240
      Width           =   615
   End
   Begin VB.CommandButton cok 
      BackColor       =   &H80000004&
      Caption         =   "&Save"
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
      Left            =   6825
      Style           =   1  'Graphical
      TabIndex        =   10
      ToolTipText     =   "Saves the problem."
      Top             =   7320
      Width           =   1215
   End
   Begin VB.CommandButton cancel 
      BackColor       =   &H80000004&
      Caption         =   "C&ancel"
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
      Left            =   8040
      Style           =   1  'Graphical
      TabIndex        =   11
      ToolTipText     =   "Undo the changes."
      Top             =   7320
      Width           =   1215
   End
   Begin VB.Frame fdcon 
      BackColor       =   &H80000004&
      Caption         =   "The Matrix"
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
      Height          =   5175
      Left            =   120
      TabIndex        =   8
      ToolTipText     =   "Matrix elements(Real or Rational)/Value of coefficients of unknowns and constant(b) in System of Linear equations"
      Top             =   1920
      Width           =   11775
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gdcon 
         Height          =   4815
         Left            =   120
         TabIndex        =   9
         ToolTipText     =   "Cell movement keys('U','D','R','L','ENTER')"
         Top             =   240
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   8493
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
      Caption         =   "Number of Rows"
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
      Left            =   120
      TabIndex        =   0
      ToolTipText     =   "Number of Rows/Linear equations"
      Top             =   960
      Width           =   5190
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
         Left            =   3825
         Style           =   1  'Graphical
         TabIndex        =   3
         ToolTipText     =   "Decrement number in the textbox by 1  "
         Top             =   225
         Width           =   1230
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
         Left            =   2580
         Style           =   1  'Graphical
         TabIndex        =   2
         ToolTipText     =   "Increment number in the textbox by 1 "
         Top             =   225
         Width           =   1230
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
         Height          =   375
         Left            =   120
         MaxLength       =   2
         TabIndex        =   1
         ToolTipText     =   "Number of Rows/Linear equations"
         Top             =   240
         Width           =   2415
      End
   End
   Begin VB.Frame fvar 
      BackColor       =   &H80000004&
      Caption         =   "Number of Columns"
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
      Height          =   810
      Left            =   6765
      TabIndex        =   4
      ToolTipText     =   "Number of Columns of the Matrix/Unknowns(>=2) in Linear equations"
      Top             =   945
      Width           =   5115
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
         Height          =   450
         Left            =   3750
         Style           =   1  'Graphical
         TabIndex        =   7
         ToolTipText     =   "Decrement number in the textbox by 1   "
         Top             =   225
         Width           =   1230
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
         Height          =   450
         Left            =   2505
         Style           =   1  'Graphical
         TabIndex        =   6
         ToolTipText     =   "Increment number in the textbox by 1  "
         Top             =   225
         Width           =   1230
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
         Height          =   420
         Left            =   120
         MaxLength       =   2
         TabIndex        =   5
         ToolTipText     =   "Number of Columns of the Matrix/Unknowns(>=2) in Linear equations"
         Top             =   240
         Width           =   2295
      End
   End
   Begin ComctlLib.StatusBar ssbar 
      Align           =   2  'Align Bottom
      Height          =   165
      Left            =   0
      TabIndex        =   15
      Top             =   7860
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
            TextSave        =   ""
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
End
Attribute VB_Name = "matxeditor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public ismatx As Boolean
Public isedit As Boolean
Public m_id As Long
Dim txtflg As Boolean
Dim con_x As Integer
Dim con_y As Integer
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
On Error GoTo xit
    tmpflg = True
    Call cok_Click
    If reflg Then Exit Sub
    foptions.istransaction = tranflg
    foptions.tmpid = m_id
    foptions.psection = IIf(ismatx, "MATX", "LSOES")
    foptions.Show
    Unload Me
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub dec_Click()
On Error GoTo xit
If Val(tvar.Text) > IIf(ismatx, 0, 1) And Val(tcon) >= 2 Then
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

    
    Call disable_all
    cok.Enabled = False
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
    
    tmpflg = False
    txtflg = False
    If ismatx Then
        Me.Caption = "Matrix Editor"
        fvar.Caption = "Number of columns"
        fvar.ToolTipText = "Specify number of columns"
        tvar.ToolTipText = "Specify number of columns"
        fcon.Caption = "Number of rows"
        fcon.ToolTipText = "Specify number of Rows"
        tcon.ToolTipText = "Specify number of Rows"
        fdcon.Caption = "Matrix"
    Else
        Me.Caption = "Linear Equations Editor"
        fvar.Caption = "Number of unknowns"
        fvar.ToolTipText = "Specify number of unknowns"
        tvar.ToolTipText = "Specify number of unknowns"
        fcon.Caption = "Number of equations"
        fcon.ToolTipText = "Specify number of Equations"
        tcon.ToolTipText = "Specify number of Equations"
        fdcon.Caption = "Linear System Of Equations"
    End If
        
    If isedit = True Then
            Call connect
            Set Y = dn.cn.Execute("select rs,cs from matx_main where matxid=" & m_id & "")
            tvar = IIf(ismatx, Val(Y.Fields("cs")), Val(Y.Fields("cs")) - 1)
            tcon = Val(Y.Fields("rs"))
            Call initialize_grids(True)
            Set Y = dn.cn.Execute("select r,c,elmnt from matx_sub1 where matxid=" & m_id)
            Y.MoveFirst
            While Not Y.EOF
                gdcon.row = Y.Fields("r")
                gdcon.col = Y.Fields("c")
                gdcon.CellAlignment = 3
                gdcon.TextMatrix(Y.Fields("r"), Y.Fields("c")) = Y.Fields("elmnt")
                Y.MoveNext
            Wend
     End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub Form_Unload(cancel As Integer)
   If Not tmpflg Then
        or_form1.Show
   End If
End Sub

Private Sub gdcon_Click()
On Error GoTo xit
   With gdcon
   If .row > 0 And .col > 0 And Not (.row > .rows - 1 And .col > .cols - 1) Then
   If Me.Visible Then
        ttmp = ""
        ttmp.Move gdcon.left + fdcon.left + gdcon.CellLeft, gdcon.Top + fdcon.Top + gdcon.CellTop, gdcon.CellWidth, gdcon.CellHeight
        ttmp.Visible = True
        ttmp.Enabled = True
        ttmp.Text = gdcon.TextMatrix(gdcon.row, gdcon.col)
        ttmp.SetFocus
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
Dim t As rat
Dim x As Double
Dim Y As Double

   If Me.Visible And ttmp.Text <> "" And con_x >= 1 And con_y >= 1 And ttmp.Visible Then
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
        gdcon.TextMatrix(con_x, con_y) = Round(x / Y, 8)
    End If
    ttmp = ""
    If con_x <= 0 Or con_y <= 0 Then
        gdcon.row = 1
        gdcon.col = 1
    End If
    Call gdcon_Click
End Sub

Private Sub inc_Click()
If Val(tvar.Text) > 0 Then
    tcon = tcon + 1
End If
End Sub

Private Sub opmi_Click()
    Call tcon_Change
End Sub
Private Sub opma_Click()
   Call tcon_Change
End Sub

Private Sub tvar_KeyPress(pKey As Integer)
On Error GoTo xit

  If pKey = 13 Then
     If gdcon.Enabled Then
        Call gdcon_GotFocus
     ElseIf fcon.Enabled Then
        tcon.SetFocus
     End If
     Exit Sub
  End If
   Call text_check_no(tvar, pKey, False, False)
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub tcon_Change()
On Error GoTo xit
    If Val(tcon) > 50 Then
        MsgBox "You can't enter a number greater than 50 here!!!", vbOKOnly, "Value cannot be accepted"
        tcon = ""
        initialize_grids (False)
        tcon.SetFocus
        Exit Sub
    End If
    
    If Val(tcon.Text) > 0 And Val(tvar.Text) > IIf(ismatx, 0, 1) Then
        initialize_grids (True)
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

Private Sub text_check_no(txt As TextBox, pKey As Integer, minus As Boolean, dot As Boolean)
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
            If x / Y > 9000000 Then
                MsgBox "Too large number", vbOKOnly, "ERROR"
                finalvalid = False
                Exit Sub
                x = 0
                Y = 1
            End If
            gdcon.row = con_x
            gdcon.col = con_y
            gdcon.CellAlignment = 3
            gdcon.TextMatrix(con_x, con_y) = Round(x / Y, 8)
      Else
            gdcon.row = con_x
            gdcon.col = con_y
            gdcon.CellAlignment = 3
            gdcon.TextMatrix(con_x, con_y) = ""
      End If
        ttmp = ""
        txtflg = False
        ttmp.Visible = False
        If pKey = 82 Or pKey = 13 Then
           If Not con_y = gdcon.cols - 1 Then
                gdcon.row = con_x
                gdcon.col = con_y + 1
                ttmp = ""
                Call gdcon_Click
           Else
                If con_x = gdcon.rows - 1 Then
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
                    gdcon.col = gdcon.cols - 1
                    ttmp = ""
                    Call gdcon_Click
                End If
            End If
    End If

   If pKey = 40 Then
           If Not con_x >= gdcon.rows - 1 Then
                gdcon.row = con_x + 1
                gdcon.col = con_y
                ttmp = ""
                Call gdcon_Click
            End If
    End If
    
    If pKey = 38 Then
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

Private Sub ttmp_KeyDown(pKey As Integer, Shift As Integer)
On Error GoTo xit
Dim t As rat
Dim x As Double
Dim Y As Double

If pKey = 82 Or pKey = 76 Or pKey = 40 Or pKey = 38 Then
        If txtflg Then
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
            gdcon.row = con_x
            gdcon.col = con_y
            gdcon.CellAlignment = 3
            gdcon.TextMatrix(con_x, con_y) = Round(x / Y, 8)
            txtflg = False
          End If

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
       
    If Val(tvar) > 50 Then
        MsgBox "You can't enter a number greater than 50 here!!!", vbOKOnly, "Value cannot be accepted"
        tvar = ""
        initialize_grids (False)
        tvar.SetFocus
        Exit Sub
    End If
    
    ttmp.Visible = False
   
    If Val(tcon.Text) > 0 And Val(tvar.Text) > IIf(ismatx, 0, 1) Then
        initialize_grids (True)
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


Public Sub initialize_grids(g_set As Boolean)
On Error GoTo xit
Dim i As Integer

    cok.Visible = True
    cok.Enabled = g_set
    cancel.Visible = True
    cancel.Enabled = g_set
    csolve.Visible = True
    csolve.Enabled = g_set
    fdcon.Enabled = g_set
    gdcon.Enabled = g_set
    
    If g_set = False Then
        gdcon.clear
        gdcon.rows = 1
        gdcon.cols = 1
        Exit Sub
    End If
    
    gdcon.rows = Val(tcon) + 1
    gdcon.cols = Val(tvar) + IIf(ismatx, 1, 2)
    gdcon.FixedCols = 1
    gdcon.FixedRows = 1
        
    For i = 1 To IIf(ismatx, gdcon.cols - 1, gdcon.cols - 2) Step 1
      gdcon.row = 0
      gdcon.col = i
      gdcon.CellAlignment = 3
       gdcon.TextMatrix(0, i) = IIf(ismatx, "COL-", "x") + Trim(str(i))
    Next i
    If Not ismatx Then
       gdcon.row = 0
       gdcon.col = i
       gdcon.CellAlignment = 3
        gdcon.TextMatrix(0, i) = "=b"
    End If
    For i = 1 To gdcon.rows - 1 Step 1
       gdcon.row = i
       gdcon.col = 0
       gdcon.CellAlignment = 3
        gdcon.TextMatrix(i, 0) = IIf(ismatx, "ROW-", "EQN-") + Trim(str(i))
    Next i
  
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
Dim optval As Long
Dim per As Long
Dim xtraflg As Boolean

reflg = True
finalvalid = True
If ttmp.Visible And ttmp.Text <> "" Then Call ttmp_KeyPress(13)
If Not finalvalid Then
    ttmp.SetFocus
    Exit Sub
End If

If Val(tvar) > 50 Or Val(tcon) > 50 Then
    MsgBox "You can't enter number of rows or number of columns of the Matrix greater than 50." & vbCrLf & "Reduce them & retry.", vbOKOnly, "ERROR!!!"
    Exit Sub
End If

Call connect
dn.cn.BeginTrans


tmp = isedit
tranflg = False
l = MsgBox(IIf(isedit, IIf(tmpflg, "Do you like to ", "") + "Overwrite existing problem?" + vbCrLf + "Yes:for overwriting." + vbCrLf + "No:for save the problem as a new problem." + vbCrLf + IIf(tmpflg, "Cancel:Proceed without saving.", "Cancel:for abort save option."), "Save the problem" + IIf(tmpflg, " before proceeding?", "?")), IIf(isedit, vbYesNoCancel, vbOKCancel), IIf(isedit, "Overwrite confirm!!!", "Save Confirm!!!"))
If l = vbCancel Then
    If Not tmpflg Then
        Exit Sub
    Else
        tranflg = True
    End If
ElseIf l = vbNo Then
    isedit = False
End If

ssbar.Visible = True
spbar.Visible = True
spbar.min = 0
spbar.max = gdcon.rows * gdcon.cols
spbar.Value = 0
ssbar.Panels(1).Text = "Validating problem entry, Please wait"

If isedit = False Then
    max_tid = getmaxid("matxid", "matx_main", -1, False)
Else
    max_tid = m_id
    dn.cn.Execute "delete from matx_sub1 where matxid=" & max_tid
    dn.cn.Execute "delete from matx_main where matxid=" & max_tid
End If

dn.cn.Execute "insert into matx_main(matxid,rs,cs) values(" & max_tid & "," & Val(tcon) & "," & IIf(ismatx, Val(tvar), Val(tvar) + 1) & ")"
xtraflg = False
For i = 1 To gdcon.rows - 1 Step 1
    For j = 1 To gdcon.cols - 1 Step 1
        If Not xtraflg And gdcon.TextMatrix(i, j) = "" Then
            optval = MsgBox("No value entered for Matrix Element(" + Trim(str(i)) + "," + Trim(str(j)) + ")." + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
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
        dn.cn.Execute "insert into matx_sub1(matxid,r,c,elmnt) values(" & max_tid & "," & i & "," & j & "," & Round(Val(gdcon.TextMatrix(i, j)), 8) & ")"
        spbar.Value = IIf(spbar.Value + 1 < spbar.max, spbar.Value + 1, spbar.max)
    Next j
Next i

spbar.Value = spbar.max

If Not tmpflg Then
    dn.cn.CommitTrans
    If ismatx Then
        or_form1.enable_menu_properly (4)
    Else
        or_form1.enable_menu_properly (5)
    End If
    
    If Not isedit Then
        MsgBox "ID provided for your problem is " & str(max_tid), vbOKOnly, "YOUR PROBLEM ID!!!"
    End If
    If tmp Then
        If isedit Then
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
        If ismatx Then
            or_form1.enable_menu_properly (4)
        Else
            or_form1.enable_menu_properly (5)
        End If
        
        If tmp Then
            If isedit Then
                Call or_form1.combopid_Click
            Else
                Call or_form1.combopid.AddItem(Trim(str(max_tid)), or_form1.combopid.ListCount)
            End If
        Else
            or_form1.enable_cntrls (False)
        End If
    End If
    m_id = max_tid
End If
spbar.Visible = False
ssbar.Visible = False
isedit = tmp
reflg = False
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub vdec_Click()
If Val(tcon.Text) > 0 And Val(tvar) >= IIf(ismatx, 2, 3) Then
    tvar = tvar - 1
End If
End Sub

Private Sub vinc_Click()
If Val(tcon.Text) > 0 Then
    tvar = tvar + 1
End If
End Sub
