#!/usr/bin/env bash

# This file is part of The RetroArena
#
# TheRA is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#
# Core script functionality is based upon The RetroPie Project https://retropie.org.uk Script Modules
#

rp_module_id="lr-vice-xpet"
rp_module_desc="PET emulator - port of VICE for libretro"
rp_module_help="ROM Extensions: .crt .d64 .g64 .prg .t64 .tap .xpet .zip .vsf\n\nCopy your Commodore PET games to $romdir/pet"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vice-libretro/master/vice/COPYING"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-vice-xpet() {
    gitPullOrClone "$md_build" https://github.com/libretro/vice-libretro.git
}

function build_lr-vice-xpet() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro EMUTYPE=xpet
    md_ret_require="$md_build/vice_xpet_libretro.so"
}

function install_lr-vice-xpet() {
    md_ret_files=(
        'vice/data'
        'vice/COPYING'
        'vice_xpet_libretro.so'
    )
}

function configure_lr-vice-xpet() {
    mkRomDir "pet"
    ensureSystemretroconfig "pet"

    cp -R "$md_inst/data" "$biosdir"
    chown -R $user:$user "$biosdir/data"

    addEmulator 1 "$md_id" "pet" "$md_inst/vice_xpet_libretro.so"
    addSystem "pet"
		chown -R $user:$user "$romdir/pet"
}
