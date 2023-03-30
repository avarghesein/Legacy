VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form registry 
   Caption         =   "ENTER DATA BASE DETAILS"
   ClientHeight    =   5565
   ClientLeft      =   1740
   ClientTop       =   2280
   ClientWidth     =   8445
   Icon            =   "registry.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5565
   ScaleWidth      =   8445
   Begin VB.CommandButton cb 
      Caption         =   "..."
      BeginProperty Font 
         Name            =   "Bookman Old Style"
         Size            =   9.75
         Charset         =   0
         Weight          =   600
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   6435
      TabIndex        =   8
      Top             =   3360
      Width           =   495
   End
   Begin MSComDlg.CommonDialog cd1 
      Left            =   7800
      Top             =   120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cnok 
      Caption         =   "CANCEL"
      Height          =   375
      Left            =   7080
      TabIndex        =   10
      Top             =   4680
      Width           =   1095
   End
   Begin VB.CommandButton cok 
      Caption         =   "OK"
      Height          =   375
      Left            =   5880
      TabIndex        =   9
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Frame fdat 
      Caption         =   "DATA SOURCE"
      Height          =   615
      Left            =   1530
      TabIndex        =   6
      Top             =   3240
      Width           =   4815
      Begin VB.TextBox tdat 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Frame fpass 
      Caption         =   "PASSWORD"
      Height          =   615
      Left            =   1530
      TabIndex        =   2
      Top             =   2520
      Width           =   4815
      Begin VB.TextBox tpass 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   120
         PasswordChar    =   "*"
         TabIndex        =   5
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Frame fuserid 
      Caption         =   "USER ID"
      Height          =   615
      Left            =   1515
      TabIndex        =   1
      Top             =   1800
      Width           =   4815
      Begin VB.TextBox tuserid 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Frame fprovider 
      Caption         =   "PROVIDER"
      Height          =   735
      Left            =   1515
      TabIndex        =   0
      Top             =   960
      Width           =   4815
      Begin VB.ComboBox procomb 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   240
         Width           =   4575
      End
      Begin VB.TextBox tprovide 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   120
         Locked          =   -1  'True
         TabIndex        =   3
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Label Label2 
      Caption         =   $"registry.frx":030A
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   120
      TabIndex        =   13
      Top             =   3960
      Width           =   4935
   End
   Begin VB.Label Label1 
      Caption         =   "We Strictly Recommand To Use  ORACLE as Provider Since, Some The  Features Of The SoftWare Is Not Supported By Other."
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1575
      TabIndex        =   12
      Top             =   240
      Width           =   5295
   End
   Begin VB.Menu phelp 
      Caption         =   "HELP"
      Begin VB.Menu phelptopic 
         Caption         =   "HELP-TOPIC"
      End
      Begin VB.Menu sep 
         Caption         =   "-"
      End
      Begin VB.Menu exitme 
         Caption         =   "EXIT"
      End
   End
End
Attribute VB_Name = "registry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim tmp_p(3) As String

Private Sub cb_Click()
On Error GoTo label
    
    cd1.InitDir = App.Path
    cd1.Filter = "data Base Files (*.mdb)|*.mdb"
    cd1.ShowOpen
    tdat = cd1.FileName
    
Exit Sub
label:
    MsgBox "No data Base Selected", vbOKOnly, "Data Base Selection Error!!!"
End Sub

Private Sub cnok_Click()
    Call del_registry
    Unload Me
End Sub

Private Sub cok_Click()
On Error GoTo label

Call del_registry

tprovide = Trim(tprovide)
tdat = Trim(tdat)


Call add_to_registry

If Trim(tprovide) = "MSDAORA.1" Then
    
    dno.cno.Open "Provider=" & tprovide & ";Data Source=" & tdat _
                 & ";User Id=" & tuserid & ";Password=" & tpass
                 
    Set dn.cn = dno.cno
    Call create_main_tables_oracle
    db_type_oracle = True
Else
    dna.cna.Open "Provider=" & tprovide & ";Data Source=" & tdat _
                 & ";User Id=" & tuserid & ";Password=" & tpass
    
    Set dn.cn = dna.cna
    
    Call create_main_tables_access
    db_type_oracle = False
End If

Unload Me
Exit Sub

label:
    Call del_registry
    MsgBox "ERROR:" & Err.Description & vbCrLf & vbCrLf & "ERROR NUMBER:" & Str(Err.Number) & _
    vbCrLf & vbCrLf & "SOURCE OF ERROR:" & Err.Source, vbOKOnly, "DATA BASE CONNECTION ERROR"

Unload Me
End Sub

Private Sub exitme_Click()
    Call cnok_Click
End Sub

Private Sub Form_Load()
    
    Call del_registry
    procomb.AddItem ("MicroSoft  Jet  OLEDB  Provider  4.0")
    procomb.ItemData(procomb.NewIndex) = 1
    tmp_p(1) = "Microsoft.Jet.OLEDB.4.0"
    procomb.AddItem ("MicroSoft  OLDB Provider  for  ORACLE")
    procomb.ItemData(procomb.NewIndex) = 2
    tmp_p(2) = "MSDAORA.1"
    procomb.Visible = False
End Sub

Private Sub phelptopic_Click()
   reporterform.hlp = True
   reporterform.Show vbModal, Me
End Sub

Private Sub procomb_click()
    If procomb.ListIndex <> -1 Then
        procomb.Visible = False
        tprovide = Trim(tmp_p(procomb.ItemData(procomb.ListIndex)))
        tuserid.SetFocus
    End If
tprovide.Visible = True
End Sub

Private Sub tdat_KeyPress(Key As Integer)
    If Key = 13 Then
        Call cok_Click
    End If
End Sub

Private Sub tpass_KeyPress(Key As Integer)
    If Key = 13 Then
        tdat.SetFocus
    End If
End Sub

Private Sub tprovide_GotFocus()
    tprovide.Visible = False
    procomb.Visible = True
    procomb.SetFocus
End Sub

Private Sub tprovide_KeyPress(Key As Integer)
    If Key = 13 Then
        Call procomb_LostFocus
    Else
        Key = 0
    End If
End Sub


Private Sub procomb_LostFocus()
    procomb.Visible = False
    Call procomb_click
End Sub

Private Sub tuserid_KeyPress(Key As Integer)
    If Key = 13 Then
        tpass.SetFocus
    End If
End Sub


