vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO murphyindustries/libultrahdr
    REF 69c1240f11e04c16dedf7e5d04a9353188c14dd4
    SHA512 4e3e866ad899f0832395122c49a7458e994587586241c72b73698e64eb79936bafc4246d2b048a9c9a72f861b03ddf17d6d8b6f72155ef18e514bbb59f148e37
    HEAD_REF apple-gainmap-jpeg
)
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DUHDR_BUILD_DEPS=OFF
)

vcpkg_cmake_build()

# libultrahdr has no install target; copy build outputs manually
set(BUILDTREES_REL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
set(BUILDTREES_DBG "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")

file(INSTALL "${BUILDTREES_REL}/uhdr.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/lib")
file(INSTALL "${BUILDTREES_REL}/uhdr.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/bin")

file(INSTALL "${BUILDTREES_DBG}/uhdr.lib" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib")
file(INSTALL "${BUILDTREES_DBG}/uhdr.dll" DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin")

file(INSTALL "${SOURCE_PATH}/ultrahdr_api.h" DESTINATION "${CURRENT_PACKAGES_DIR}/include")
file(INSTALL "${SOURCE_PATH}/README.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
