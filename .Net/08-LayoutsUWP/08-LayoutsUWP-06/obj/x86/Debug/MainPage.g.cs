﻿#pragma checksum "D:\Escritorio\.Net-Ejercicios\.Net\08-LayoutsUWP\08-LayoutsUWP-06\MainPage.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "A0CA0B4374DA4B1BC35418193C37EF52"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace _08_LayoutsUWP_06
{
    partial class MainPage : 
        global::Windows.UI.Xaml.Controls.Page, 
        global::Windows.UI.Xaml.Markup.IComponentConnector,
        global::Windows.UI.Xaml.Markup.IComponentConnector2
    {
        /// <summary>
        /// Connect()
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.Windows.UI.Xaml.Build.Tasks"," 10.0.18362.1")]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        public void Connect(int connectionId, object target)
        {
            switch(connectionId)
            {
            case 2: // MainPage.xaml line 94
                {
                    this.txkFormularioGuardado = (global::Windows.UI.Xaml.Controls.TextBlock)(target);
                }
                break;
            case 3: // MainPage.xaml line 25
                {
                    this.stpNombre = (global::Windows.UI.Xaml.Controls.StackPanel)(target);
                }
                break;
            case 4: // MainPage.xaml line 42
                {
                    this.txkErrorNombre = (global::Windows.UI.Xaml.Controls.TextBlock)(target);
                }
                break;
            case 5: // MainPage.xaml line 49
                {
                    this.stpApellidos = (global::Windows.UI.Xaml.Controls.StackPanel)(target);
                }
                break;
            case 6: // MainPage.xaml line 65
                {
                    this.txkErrorApellidos = (global::Windows.UI.Xaml.Controls.TextBlock)(target);
                }
                break;
            case 7: // MainPage.xaml line 72
                {
                    this.stpFecha = (global::Windows.UI.Xaml.Controls.StackPanel)(target);
                }
                break;
            case 8: // MainPage.xaml line 87
                {
                    this.txkErrorFecha = (global::Windows.UI.Xaml.Controls.TextBlock)(target);
                }
                break;
            case 9: // MainPage.xaml line 76
                {
                    this.txkFecha = (global::Windows.UI.Xaml.Controls.TextBlock)(target);
                }
                break;
            case 10: // MainPage.xaml line 80
                {
                    this.txbFecha = (global::Windows.UI.Xaml.Controls.TextBox)(target);
                }
                break;
            case 11: // MainPage.xaml line 54
                {
                    this.txkApellidos = (global::Windows.UI.Xaml.Controls.TextBlock)(target);
                }
                break;
            case 12: // MainPage.xaml line 58
                {
                    this.txbApellidos = (global::Windows.UI.Xaml.Controls.TextBox)(target);
                }
                break;
            case 13: // MainPage.xaml line 30
                {
                    this.txkNombre = (global::Windows.UI.Xaml.Controls.TextBlock)(target);
                }
                break;
            case 14: // MainPage.xaml line 34
                {
                    this.txbNombre = (global::Windows.UI.Xaml.Controls.TextBox)(target);
                }
                break;
            case 15: // MainPage.xaml line 13
                {
                    this.abbAdd = (global::Windows.UI.Xaml.Controls.AppBarButton)(target);
                    ((global::Windows.UI.Xaml.Controls.AppBarButton)this.abbAdd).Click += this.nuevoFormulario;
                }
                break;
            case 16: // MainPage.xaml line 16
                {
                    this.abbSave = (global::Windows.UI.Xaml.Controls.AppBarButton)(target);
                    ((global::Windows.UI.Xaml.Controls.AppBarButton)this.abbSave).Click += this.guardarFormulario;
                }
                break;
            case 17: // MainPage.xaml line 19
                {
                    this.abbDelete = (global::Windows.UI.Xaml.Controls.AppBarButton)(target);
                    ((global::Windows.UI.Xaml.Controls.AppBarButton)this.abbDelete).Click += this.borrarFormulario;
                }
                break;
            default:
                break;
            }
            this._contentLoaded = true;
        }

        /// <summary>
        /// GetBindingConnector(int connectionId, object target)
        /// </summary>
        [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.Windows.UI.Xaml.Build.Tasks"," 10.0.18362.1")]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        public global::Windows.UI.Xaml.Markup.IComponentConnector GetBindingConnector(int connectionId, object target)
        {
            global::Windows.UI.Xaml.Markup.IComponentConnector returnValue = null;
            return returnValue;
        }
    }
}
