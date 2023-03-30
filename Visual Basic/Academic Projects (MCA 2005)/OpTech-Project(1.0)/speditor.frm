VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "MSHFLXGD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form speditor 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Sequential Problem Editor"
   ClientHeight    =   8340
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11910
   BeginProperty Font 
      Name            =   "Book Antiqua"
      Size            =   9
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00400000&
   Icon            =   "speditor.frx":0000
   LinkTopic       =   "Form1"
   Picture         =   "speditor.frx":0442
   ScaleHeight     =   8340
   ScaleWidth      =   11910
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
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
      Left            =   8160
      Style           =   1  'Graphical
      TabIndex        =   17
      ToolTipText     =   "Undo the changes."
      Top             =   7320
      Width           =   1215
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
      Left            =   6945
      Style           =   1  'Graphical
      TabIndex        =   16
      ToolTipText     =   "Saves the problem."
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
      Left            =   10575
      Style           =   1  'Graphical
      TabIndex        =   15
      ToolTipText     =   "Exit to main menu"
      Top             =   7320
      Width           =   1215
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
      Left            =   9360
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "Solves the current problem"
      Top             =   7320
      Width           =   1215
   End
   Begin VB.ComboBox tcomb 
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
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   2760
      Style           =   2  'Dropdown List
      TabIndex        =   11
      Top             =   360
      Width           =   735
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
      ForeColor       =   &H80000002&
      Height          =   375
      Left            =   4320
      MaxLength       =   12
      TabIndex        =   10
      ToolTipText     =   "Enter a real number>=0"
      Top             =   480
      Width           =   615
   End
   Begin VB.Frame fdcon 
      BackColor       =   &H80000004&
      Caption         =   "Details Of Time Duration Of Each Job In Each Machine"
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
      Left            =   105
      TabIndex        =   8
      ToolTipText     =   "Details about time needed by each Job  & execution order(If problem type is K-Machines 2-jobs) of machines in the current SP."
      Top             =   1785
      Width           =   11790
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid gdcon 
         Height          =   4935
         Left            =   120
         TabIndex        =   9
         ToolTipText     =   "Cell movement keys('U','D','R','L','ENTER')"
         Top             =   285
         Width           =   11535
         _ExtentX        =   20346
         _ExtentY        =   8705
         _Version        =   393216
         BackColor       =   16777215
         BackColorFixed  =   8421504
         ForeColorFixed  =   -2147483624
         BackColorBkg    =   -2147483644
         GridLines       =   2
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
      Caption         =   "Number of Machines"
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
      Left            =   105
      TabIndex        =   0
      ToolTipText     =   "Number of Machines in the current SP."
      Top             =   945
      Width           =   4695
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
         Height          =   405
         Left            =   3600
         Style           =   1  'Graphical
         TabIndex        =   3
         ToolTipText     =   "Decrements the number of Machines by 1."
         Top             =   225
         Width           =   990
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
         Height          =   405
         Left            =   2580
         Style           =   1  'Graphical
         TabIndex        =   2
         ToolTipText     =   "Increments the number of Machines by 1."
         Top             =   225
         Width           =   1005
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
         Height          =   285
         Left            =   120
         MaxLength       =   2
         TabIndex        =   1
         ToolTipText     =   "Number of Machines in the current SP."
         Top             =   240
         Width           =   2415
      End
   End
   Begin VB.Frame fvar 
      BackColor       =   &H80000004&
      Caption         =   "Number of Jobs"
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
      Left            =   7215
      TabIndex        =   4
      ToolTipText     =   "Number of Jobs in the current SP."
      Top             =   930
      Width           =   4680
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
         Height          =   435
         Left            =   3525
         Style           =   1  'Graphical
         TabIndex        =   7
         ToolTipText     =   "Decrements the number of Jobs by 1."
         Top             =   210
         Width           =   1035
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
         Height          =   435
         Left            =   2460
         Style           =   1  'Graphical
         TabIndex        =   6
         ToolTipText     =   "Increments the number of Jobs by 1."
         Top             =   210
         Width           =   1035
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
         Height          =   360
         Left            =   120
         MaxLength       =   2
         TabIndex        =   5
         ToolTipText     =   "Number of Jobs in the current SP."
         Top             =   240
         Width           =   2295
      End
   End
   Begin ComctlLib.StatusBar ssbar 
      Align           =   2  'Align Bottom
      Height          =   240
      Left            =   0
      TabIndex        =   12
      Top             =   8100
      Width           =   11910
      _ExtentX        =   21008
      _ExtentY        =   423
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
   Begin ComctlLib.ProgressBar spbar 
      Align           =   2  'Align Bottom
      Height          =   210
      Left            =   0
      TabIndex        =   13
      Top             =   7890
      Width           =   11910
      _ExtentX        =   21008
      _ExtentY        =   370
      _Version        =   327682
      Appearance      =   1
   End
End
Attribute VB_Name = "speditor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public s_type As String
Public isedit As Boolean
Public sid As Long
Dim lflg As Boolean
Dim pflg As Boolean
Dim con_x As Integer
Dim con_y As Integer
Dim tmpflg As Boolean
Dim tranflg As Boolean
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
    tcomb.Enabled = True
    tcomb.Visible = False
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
    foptions.tmpid = sid
    foptions.psection = "SP"
    foptions.psubsection = s_type
    foptions.Show
    Unload Me
End Sub

Private Sub dec_Click()
If Val(tvar.Text) > 0 And ((s_type = "J2" And Val(tcon) >= 2) Or (s_type = "MK" And Val(tcon) > 3)) Then
    tcon = tcon - 1
End If
End Sub

Private Sub Form_GotFocus()
ttmp.Visible = False
tcomb.Visible = False
End Sub

Private Sub Form_load()
On Error GoTo xit
Dim Y As New Recordset
    
    Call disable_all
    lflg = False
    pflg = False
    spbar.Visible = False
    ssbar.Visible = False
    tmpflg = False
    
    csolve.Visible = True
    cok.Visible = True
    cexit.Visible = True
    cancel.Visible = True
    csolve.Enabled = False
    cok.Enabled = False
    cancel.Enabled = False
    cexit.Enabled = True
    
    If s_type = "M2" Or s_type = "M3" Or s_type = "MK" Then
        Me.HelpContextID = 10
        fdcon.Caption = "Enter time needed  by each job in each Machine"
        If s_type <> "MK" Then fcon.Enabled = False
        fvar.Enabled = True
        tcon.Text = IIf(s_type = "M2", "2", IIf(s_type = "M3", "3", "3"))
    Else
        If s_type = "J2" Then
            Me.HelpContextID = 11
            fdcon.Caption = "Enter time needed by job in Machine[cols 2-3], Execution order of Machine in Job[cols 4-5]"
            fcon.Enabled = True
            fvar.Enabled = False
            tvar.Text = "2"
        End If
    End If
    
    If isedit Then
        Call connect
        Set Y = dn.cn.Execute("select ms,js from sp_main where sid=" & sid & "")
        tcon = Y.Fields("ms")
        tvar = Y.Fields("js")
        Call initialize_grids(True)
        Set Y = dn.cn.Execute("select mac,job,time_dur,e_order from sp_sub1 where sid=" & sid & "")
        Y.MoveFirst
        While Not Y.EOF
            gdcon.TextMatrix(Y.Fields("mac"), Y.Fields("job")) = Y.Fields("time_dur")
            If s_type = "J2" Then
                If Y.Fields("job") = 1 Then
                    gdcon.TextMatrix(Y.Fields("mac"), 3) = Y.Fields("e_order")
                Else
                    gdcon.TextMatrix(Y.Fields("mac"), 4) = Y.Fields("e_order")
                End If
            End If
            Y.MoveNext
        Wend
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

Private Sub Form_Unload(cancel As Integer)
    If Not tmpflg Then
        or_form1.Show
    End If
End Sub

Private Sub gdcon_Click()
On Error GoTo xit
Dim i As Integer
With gdcon
If .row > 0 And .col > 0 And .row <= .rows - 1 And .col <= .cols - 1 Then
If Me.Visible Then
  con_x = gdcon.row
  con_y = gdcon.col
  If s_type <> "J2" Or (s_type = "J2" And con_y < 3) Then
        ttmp = ""
        ttmp.Move gdcon.left + fdcon.left + gdcon.CellLeft, gdcon.Top + fdcon.Top + gdcon.CellTop, gdcon.CellWidth, gdcon.CellHeight
        ttmp.Visible = True
        ttmp.Enabled = True
        tcomb.Visible = False
        ttmp.Text = gdcon.TextMatrix(gdcon.row, gdcon.col)
        ttmp.SetFocus
  Else
        tcomb.clear
        For i = 1 To gdcon.rows - 1 Step 1
            Call tcomb.AddItem(i, i - 1)
        Next i
        tcomb.Move gdcon.left + fdcon.left + gdcon.CellLeft, gdcon.Top + fdcon.Top + gdcon.CellTop, gdcon.CellWidth
        ttmp.Visible = False
        tcomb.Visible = True
        tcomb.Enabled = True
        pflg = True
        tcomb.ListIndex = IIf(Val(.TextMatrix(.row, .col)) >= 1, Val(.TextMatrix(.row, .col)) - 1, -1)
        pflg = False
        tcomb.SetFocus
  End If
End If
End If
Exit Sub
End With
xit:
    Call error_me(Me)
End Sub



Private Sub gdcon_GotFocus()
  If Me.Visible And con_x >= 1 And con_y >= 1 And ((s_type <> "J2" And con_y < gdcon.cols) Or (s_type = "J2" And con_y < 3)) And ttmp.Text <> "" And ttmp.Visible Then
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



Private Sub tcomb_Click()
On Error GoTo xit
Dim i As Integer
If tcomb.ListIndex <> -1 And Not pflg Then
    gdcon.TextMatrix(con_x, con_y) = tcomb.List(tcomb.ListIndex)
    For i = 1 To gdcon.rows - 1 Step 1
        If i <> con_x Then
            If gdcon.TextMatrix(i, con_y) = gdcon.TextMatrix(con_x, con_y) Then
                gdcon.TextMatrix(i, con_y) = ""
            End If
        End If
    Next i
    If con_y = gdcon.cols - 1 Then
        con_y = 1
        If con_x = gdcon.rows - 1 Then
            con_x = 1
        Else
            con_x = con_x + 1
        End If
    Else
        con_y = con_y + 1
    End If
    gdcon.row = con_x
    gdcon.col = con_y
    Call gdcon_Click
End If
pflg = False
Exit Sub
xit:
    Call error_me(Me)
End Sub


Private Sub tcomb_KeyPress(Key As Integer)
    Key = 0
End Sub

Private Sub tcomb_keydown(Key As Integer, Shift As Integer)
Dim i As Long
    If Not (Key = 13 Or Key = 82 Or Key = 76 Or Key = 85 Or Key = 68) Then
        pflg = True
        Exit Sub
    End If
    pflg = True
    If tcomb.ListIndex <> -1 Then
        gdcon.TextMatrix(con_x, con_y) = tcomb.List(tcomb.ListIndex)
        For i = 1 To gdcon.rows - 1 Step 1
            If i <> con_x Then
                If gdcon.TextMatrix(i, con_y) = gdcon.TextMatrix(con_x, con_y) Then
                    gdcon.TextMatrix(i, con_y) = ""
                End If
            End If
        Next i
    End If
    With gdcon
          If Key = 82 Or Key = 13 Then
            If Not con_y >= .cols - 1 Then
                .col = con_y + 1
                .row = con_x
                Call gdcon_Click
            Else
                If con_x = .rows - 1 Then
                    tcomb.Visible = False
                    cok.SetFocus
                Else
                    .row = con_x + 1
                    .col = 1
                    lflg = False
                    Call gdcon_Click
                End If
            End If
        End If
        
    If Key = 76 Then
       gdcon.row = con_x
       gdcon.col = con_y - 1
       ttmp = ""
       Call gdcon_Click
       
   End If
   If Key = 85 And con_x > 1 Then
        gdcon.row = con_x - 1
        gdcon.col = con_y
        ttmp = ""
        Call gdcon_Click
       
   End If
   If Key = 68 And con_x < gdcon.rows - 1 Then
        gdcon.row = con_x + 1
        gdcon.col = con_y
        ttmp = ""
        Call gdcon_Click
   End If
   End With
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
        lflg = True
        t1 = UCase(t1)
        pKey = Asc(t1)
        If pKey = 82 Or pKey = 13 Then
            If Not con_y >= gdcon.cols - 1 Then
                If s_type = "J2" And con_y = 1 Then
                    gdcon.row = con_x
                    gdcon.col = con_y + 1
                    Call gdcon_Click
                Else
                    gdcon.row = con_x
                    gdcon.col = con_y + 1
                    Call gdcon_Click
                End If
            Else
                If s_type <> "J2" Then
                    If con_x <> gdcon.rows - 1 Then
                        gdcon.row = con_x + 1
                        gdcon.col = 1
                        Call gdcon_Click
                    Else
                        ttmp = ""
                        ttmp.Visible = False
                        cok.SetFocus
                    End If
                End If
            End If
        End If
        
        If pKey = 76 Then
            If Not con_y <= 1 Then
                gdcon.col = con_y - 1
                gdcon.row = con_x
                Call gdcon_Click
            Else
                If con_x <= 1 Then
                    ttmp = ""
                    ttmp.Visible = False
                    tcon.SetFocus
                Else
                gdcon.col = gdcon.cols - 1
                gdcon.row = con_x - 1
                Call gdcon_Click
            End If
          End If
        End If
    
        If pKey = 68 Then
           If Not con_x = gdcon.rows - 1 Then
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
    
   Call text_check_no(ttmp, pKey, False, True)

Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub inc_Click()
On Error GoTo xit
If Val(tvar.Text) > 0 Then
    If s_type = "MK" And Val(tcon) < 3 Then
        tcon = "3"
    Else
        tcon = tcon + 1
    End If
End If
Exit Sub
xit:
    Call error_me(Me)
End Sub

Private Sub tcon_Change()
On Error GoTo xit
    ttmp.Visible = False
    tcomb.Visible = False
    If Val(tcon) > 50 Then
        MsgBox "You can't enter a number greater than 50 here!!!", vbOKOnly, "Value cannot be accepted"
        tcon = ""
        initialize_grids (False)
        tcon.SetFocus
        Exit Sub
    End If
    
    If s_type = "MK" And tcon <> "" And Val(tcon) < 3 Then tcon = "3"
    
    If (s_type <> "MK" And Val(tcon.Text) > 0 And Val(tvar.Text) > 0) Or (s_type = "MK" And Val(tcon.Text) >= 3 And Val(tvar.Text) > 0) Then
        initialize_grids (True)
        inc.Enabled = True
        If (s_type <> "MK" And Val(tcon.Text) > 1) Or Val(tcon) > 3 Then
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
    tcomb.Visible = False
 
    If Val(tvar) > 50 Then
        MsgBox "You can't enter a number greater than 50 here!!!", vbOKOnly, "Value cannot be accepted"
        tvar = ""
        initialize_grids (False)
        tvar.SetFocus
        Exit Sub
    End If
   
    If (s_type <> "MK" And Val(tcon.Text) > 0 And Val(tvar.Text) > 0) Or (s_type = "MK" And Val(tcon.Text) >= 3 And Val(tvar.Text) > 0) Then
        initialize_grids (True)
        inc.Enabled = True
        If (s_type <> "MK" And Val(tcon.Text) > 1) Or Val(tcon) > 3 Then
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
    If s_type <> "J2" Then
        gdcon.cols = Val(tvar) + 1
    Else
        gdcon.cols = Val(tvar) + 3
        gdcon.TextMatrix(0, 3) = "Turn on Job1"
        gdcon.TextMatrix(0, 4) = "Turn on Job2"
    End If
    gdcon.FixedCols = 1
    gdcon.FixedRows = 1
    For i = 0 To gdcon.cols - 1 Step 1
           If s_type <> "J2" Then
                gdcon.ColWidth(i) = 1200
           Else
                gdcon.ColWidth(i) = 1320
           End If
    Next i
    For i = 1 To IIf(s_type = "J2", 2, gdcon.cols - 1) Step 1
       gdcon.TextMatrix(0, i) = IIf(s_type = "J2", "Time on Job", "Job-") & Trim(str(i))
    Next i
    
    For i = 1 To gdcon.rows - 1 Step 1
        gdcon.TextMatrix(i, 0) = "Machine-" & Trim(str(i))
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
    MsgBox "You can't enter number of rows or number of columns of the editing grid greater than 50." & vbCrLf & "Reduce them & retry.", vbOKOnly, "ERROR!!!"
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
spbar.max = gdcon.rows * gdcon.cols
spbar.min = 0

spbar.Value = 0
ssbar.Panels(1).Text = "Validating problem entry, Please wait"

If s_type = "J2" Then
    tcomb.clear
    For i = 1 To gdcon.rows - 1 Step 1
         tcomb.AddItem i, i - 1
    Next i
    For i = 1 To gdcon.rows - 1 Step 1
        If Val(gdcon.TextMatrix(i, 3)) > 0 Then
            j = indexincombo(tcomb, gdcon.TextMatrix(i, 3))
            If j <> -1 Then tcomb.RemoveItem (j)
        End If
    Next i
    For i = 1 To gdcon.rows - 1 Step 1
        If Val(gdcon.TextMatrix(i, 3)) <= 0 Then
            gdcon.TextMatrix(i, 3) = tcomb.List(0)
            tcomb.RemoveItem (0)
        End If
    Next i
    tcomb.clear
    For i = 1 To gdcon.rows - 1 Step 1
         tcomb.AddItem i, i - 1
    Next i
    
    For i = 1 To gdcon.rows - 1 Step 1
        If Val(gdcon.TextMatrix(i, 4)) > 0 Then
            j = indexincombo(tcomb, gdcon.TextMatrix(i, 4))
            If j <> -1 Then tcomb.RemoveItem (j)
        End If
    Next i
    For i = 1 To gdcon.rows - 1 Step 1
        If Val(gdcon.TextMatrix(i, 4)) <= 0 Then
            gdcon.TextMatrix(i, 4) = tcomb.List(0)
            tcomb.RemoveItem (0)
        End If
    Next i
End If

If isedit = False Then
    max_tid = getmaxid("sid", "sp_main", -1, False)
Else
    max_tid = sid
    dn.cn.Execute "delete from sp_sub1 where sid=" & max_tid
    dn.cn.Execute "delete from sp_main where sid=" & max_tid
End If

dn.cn.Execute "insert into sp_main(sid,ms,js,s_type) values(" & max_tid & "," & Val(tcon) & "," & Val(tvar) & ",'" & Trim(s_type) & "')"

xtraflg = False
For i = 1 To gdcon.rows - 1 Step 1
    For j = 1 To IIf(s_type = "J2", 2, gdcon.cols - 1) Step 1
        If Not xtraflg And gdcon.TextMatrix(i, j) = "" Then
            optval = MsgBox("No Time value entered for Machine-" + Trim(str(i)) + ",Job-" + Trim(str(j)) + "." + vbCrLf + "Do you like to use 0(Zero) instead." + vbCrLf + vbCrLf + "Yes:I like to proceed with the value 0." + vbCrLf + "No:I like to re-edit the value" + vbCrLf + "Cancel:Ignore all such entries", vbYesNoCancel, "Invalid Data Entry Found!!!")
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
        If s_type = "J2" Then
            dn.cn.Execute "insert into sp_sub1(sid,mac,job,time_dur,e_order) values(" & max_tid & "," & i & "," & j & "," & Val(gdcon.TextMatrix(i, j)) & "," & IIf(j = 1, gdcon.TextMatrix(i, 3), gdcon.TextMatrix(i, 4)) & ")"
        Else
            dn.cn.Execute "insert into sp_sub1(sid,mac,job,time_dur,e_order) values(" & max_tid & "," & i & "," & j & "," & Val(gdcon.TextMatrix(i, j)) & ",null)"
        End If
        spbar.Value = IIf(spbar.Value + 1 < spbar.max, spbar.Value + 1, spbar.max)
    Next j
Next i
spbar.Value = spbar.max
If Not tmpflg Then
    dn.cn.CommitTrans
    If s_type = "M2" Then
        or_form1.enable_menu_properly (6)
    ElseIf s_type = "M3" Then
        or_form1.enable_menu_properly (7)
    ElseIf s_type = "J2" Then
        or_form1.enable_menu_properly (8)
    ElseIf s_type = "MK" Then
        or_form1.enable_menu_properly (9)
    End If
    
    If Not isedit Then
        MsgBox "ID provided for your problem is " & str(max_tid), vbOKOnly, "YOUR PROBLEM ID!!!"
    Else
        Call or_form1.combopid_Click
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
    
    If s_type = "M2" Then
        or_form1.enable_menu_properly (6)
    ElseIf s_type = "M3" Then
        or_form1.enable_menu_properly (7)
    ElseIf s_type = "J2" Then
        or_form1.enable_menu_properly (8)
    ElseIf s_type = "MK" Then
        or_form1.enable_menu_properly (9)
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
    sid = max_tid
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
On Error GoTo xit
If Val(tcon) > 0 And Val(tvar) >= 2 Then
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
