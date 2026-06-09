vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO murphyindustries/libultrahdr
    REF 154127aec5aa18f05ca37fa63caf3460d32954df
    SHA512 50c2bd6659609ae8e3a643130cc7e4c9bca81296698dbc61bcc34c359c9d4cb562469e4f4ced5dd40aa8afbd286c855ebb09a11a8207d5ee01f269722097f191
    HEAD_REF master
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
