# SetVolumeMax.ps1

# Crear un objeto COM para controlar el sonido del sistema
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Sound {
        [DllImport("user32.dll")]
        public static extern int SendMessageW(IntPtr hWnd, int Msg, IntPtr wParam, IntPtr lParam);
        public const int APPCOMMAND_VOLUME_MAX = 0xA0000;
        public const int WM_APPCOMMAND = 0x319;
        public static void SetVolumeMax() {
            SendMessageW(GetForegroundWindow(), WM_APPCOMMAND, IntPtr.Zero, (IntPtr)APPCOMMAND_VOLUME_MAX);
        }
        [DllImport("user32.dll")]
        private static extern IntPtr GetForegroundWindow();
    }
"@

# Ejecutar la función que ajusta el volumen al máximo
[Sound]::SetVolumeMax()
