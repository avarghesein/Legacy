VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form registry 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Enter Details Regarding The Database"
   ClientHeight    =   6015
   ClientLeft      =   1830
   ClientTop       =   1905
   ClientWidth     =   8445
   HelpContextID   =   4
   Icon            =   "registry.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   Picture         =   "registry.frx":0442
   ScaleHeight     =   6015
   ScaleWidth      =   8445
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cb 
      BackColor       =   &H80000004&
      Caption         =   "&Browse..."
      Height          =   375
      Left            =   6435
      Style           =   1  'Graphical
      TabIndex        =   9
      ToolTipText     =   "Browse the Data source of the database if it is of MS-Access type."
      Top             =   3960
      Width           =   975
   End
   Begin MSComDlg.CommonDialog cd1 
      Left            =   7800
      Top             =   120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cnok 
      BackColor       =   &H80000004&
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   7080
      Style           =   1  'Graphical
      TabIndex        =   11
      ToolTipText     =   "Undo."
      Top             =   4680
      Width           =   1095
   End
   Begin VB.CommandButton cok 
      BackColor       =   &H80000004&
      Caption         =   "&Ok"
      Height          =   375
      Left            =   5985
      Style           =   1  'Graphical
      TabIndex        =   10
      ToolTipText     =   "Accept the details of the database."
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Frame fdat 
      BackColor       =   &H80000004&
      Caption         =   "Data source"
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   1515
      TabIndex        =   7
      ToolTipText     =   "Data source of the database."
      Top             =   3735
      Width           =   4815
      Begin VB.TextBox tdat 
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   120
         TabIndex        =   8
         ToolTipText     =   "Data source of the database.Type if you remmeber, otherwise click the browse button."
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Frame fpass 
      BackColor       =   &H80000004&
      Caption         =   "Password(if any)"
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   1515
      TabIndex        =   5
      ToolTipText     =   "Specify the password of the database if any otherwise type nothing."
      Top             =   3015
      Width           =   4815
      Begin VB.TextBox tpass 
         BackColor       =   &H00FFFFFF&
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   120
         PasswordChar    =   "*"
         TabIndex        =   6
         ToolTipText     =   "Specify the password of the database if any otherwise type nothing."
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Frame fuserid 
      BackColor       =   &H80000004&
      Caption         =   "User id"
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   1515
      TabIndex        =   3
      ToolTipText     =   "User Id of the DataBase selected."
      Top             =   2295
      Width           =   4815
      Begin VB.TextBox tuserid 
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   120
         TabIndex        =   4
         ToolTipText     =   "User Id of the DataBase selected."
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Frame fprovider 
      BackColor       =   &H80000004&
      Caption         =   "Provider of the database"
      ForeColor       =   &H80000008&
      Height          =   735
      Left            =   1515
      TabIndex        =   1
      ToolTipText     =   "Provider of the Databse."
      Top             =   1440
      Width           =   4815
      Begin VB.ComboBox procomb 
         BackColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   2
         ToolTipText     =   "Provider of the Databse.(Select one from the box)"
         Top             =   270
         Width           =   4575
      End
      Begin VB.TextBox tprovide 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   120
         Locked          =   -1  'True
         TabIndex        =   12
         ToolTipText     =   "Provider of the Databse.(click here!!!)"
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Label Label2 
      Caption         =   $"registry.frx":130C
      ForeColor       =   &H80000008&
      Height          =   1095
      Left            =   120
      TabIndex        =   13
      Top             =   4440
      Width           =   4935
   End
   Begin VB.Label Label1 
      BackColor       =   &H80000004&
      Caption         =   $"registry.frx":1453
      ForeColor       =   &H80000008&
      Height          =   660
      Left            =   1575
      TabIndex        =   0
      Top             =   645
      Width           =   5295
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
    
    cd1.InitDir = App.path
    cd1.Filter = "data Base Files (*.mdb)|*.mdb"
    cd1.ShowOpen
    tdat = cd1.FileName
    
Exit Sub
label:
    MsgBox "No data Base Selected", vbOKOnly, "OpTech:Data Base Selection Error!!!"
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


Call add_to_registry(tprovide, tdat, tuserid, tpass)

If Trim(tprovide) = "MSDAORA.1" Then
    Call SendKeys("{ESC}")
    dno.cno.Open "Provider=" & tprovide & ";Data Source=" & tdat _
                 & ";User Id=" & tuserid & ";Password=" & tpass
                 
    Set dn.cn = dno.cno
    Call create_main_tables_oracle
    db_type_oracle = True
Else
    Call SendKeys("{ESC}")
    dna.cna.Open "Provider=" & tprovide & ";Data Source=" & tdat _
                 & ";User Id=" & tuserid & ";Password=" & tpass
    
    Set dn.cn = dna.cna
    
    Call create_main_tables_access
    db_type_oracle = False
End If

frmSplash.Show
Unload Me
Exit Sub

label:
    Call del_registry
    MsgBox "ERROR:" & Err.Description & vbCrLf & vbCrLf & "ERROR NUMBER:" & str(Err.Number) & _
    vbCrLf & vbCrLf & "SOURCE OF ERROR:" & Err.Source, vbOKOnly, "OpTech:DATA BASE CONNECTION ERROR"

Unload Me
End Sub

Private Sub exitme_Click()
    Call cnok_Click
End Sub

Private Sub Form_load()
    
    Call del_registry
    procomb.AddItem ("Use MicroSoft-Access for OpTech")
    procomb.ItemData(procomb.NewIndex) = 1
    tmp_p(1) = "Microsoft.Jet.OLEDB.4.0"
    procomb.AddItem ("Use ORACLE(8I/9I) for OpTech")
    procomb.ItemData(procomb.NewIndex) = 2
    tmp_p(2) = "MSDAORA.1"
    procomb.Visible = False
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


Private Sub tprovide_GotFocus()
    tprovide.Visible = False
    procomb.Visible = True
    procomb.SetFocus
End Sub
