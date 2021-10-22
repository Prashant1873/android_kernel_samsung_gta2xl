rm -rf out
tcdir=${HOME}/android/TOOLS/GCC
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 $tcdir/los-4.9-64
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 $tcdir/los-4.9-32
 make O=out ARCH=arm64 gta2xllte_defconfig
PATH="$tcdir/los-4.9-64/bin:$tcdir/los-4.9-32/bin:${PATH}" \
 make    O=out \
      ARCH=arm64 \
         CC="ccache $tcdir/los-4.9-64/bin/aarch64-linux-android-gcc" \
         CROSS_COMPILE=aarch64-linux-android- \
         CROSS_COMPILE_ARM32=arm-linux-androideabi- \
        CONFIG_NO_ERROR_ON_MISMATCH=y \
         CONFIG_DEBUG_SECTION_MISMATCH=y \
       -j$(nproc --all) || exit
git clone https://github.com/Prashant1873/Anykerne-3.git -b new
cp out/arch/arm64/boot/Image.gz-dtb Anykerne-3/
zip -r9 test.zip * -x .git README.md
cd ..
git clone https://github.com/Prashant1873/telegram.git Telegram
DATE=$(date +"%Y%m%d-%H%M")
 TELEGRAM=Telegram/telegram
 CHANNEL_ID=-1001261511799
 "${TELEGRAM}" -f "$(echo "$(pwd)"/AnyKerne-3/*.zip)" -c "${CHANNEL_ID}" -H "TAb"
