VERSION 5.00
Object = "{0D452EE1-E08F-101A-852E-02608C4D0BB4}#2.0#0"; "FM20.DLL"
Begin VB.Form fabout 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "About MyApp"
   ClientHeight    =   2625
   ClientLeft      =   4770
   ClientTop       =   5430
   ClientWidth     =   6735
   ClipControls    =   0   'False
   Icon            =   "fabout.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1811.822
   ScaleMode       =   0  'User
   ScaleWidth      =   6324.513
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame3 
      Height          =   120
      Index           =   1
      Left            =   2655
      TabIndex        =   8
      Top             =   1425
      Width           =   4080
   End
   Begin VB.Frame Frame3 
      Height          =   120
      Index           =   0
      Left            =   2655
      TabIndex        =   6
      Top             =   615
      Width           =   4080
   End
   Begin VB.Frame Frame2 
      Height          =   720
      Left            =   2850
      TabIndex        =   4
      Top             =   1680
      Width           =   3660
      Begin VB.Label Label2 
         Caption         =   "ScienTech is a simple and easy to use Scientific Calculator, with expression solving facility."
         Height          =   420
         Left            =   135
         TabIndex        =   5
         Top             =   210
         Width           =   3420
      End
   End
   Begin MSForms.CommandButton cmd 
      Height          =   360
      Left            =   5550
      TabIndex        =   7
      Top             =   165
      Width           =   1080
      ForeColor       =   12583104
      Caption         =   "OK"
      Size            =   "1905;635"
      FontHeight      =   165
      FontCharSet     =   0
      FontPitchAndFamily=   2
      ParagraphAlign  =   3
   End
   Begin VB.Label Label1 
      Caption         =   "De Paul Institute of Science and Technology"
      Height          =   240
      Left            =   2985
      TabIndex        =   3
      Top             =   1140
      Width           =   3495
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   2640
      Left            =   0
      Picture         =   "fabout.frx":0442
      Stretch         =   -1  'True
      Top             =   0
      Width           =   2655
   End
   Begin VB.Label lblDescription 
      Caption         =   "Copyright © 2005 - 2010"
      Height          =   225
      Left            =   2985
      TabIndex        =   0
      Top             =   855
      Width           =   1815
   End
   Begin VB.Label lblTitle 
      Caption         =   "ScienTech. Version 1.0"
      Height          =   255
      Left            =   2985
      TabIndex        =   1
      Top             =   135
      Width           =   2025
   End
   Begin VB.Label lblVersion 
      Caption         =   "For Windows platform"
      Height          =   195
      Left            =   2985
      TabIndex        =   2
      Top             =   360
      Width           =   1980
   End
End
Attribute VB_Name = "fabout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmd_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Me.Caption = "About ScienTech 1.0"
End Sub

