
#include "steam/isteamnetworkingsockets.h"
#include "steam/isteamnetworkingutils.h"
#include "steam/steamnetworkingsockets.h"
#include <stdint.h>

extern "C" int LLVMFuzzerInitialize(int *argc, char ***argv) {
  SteamDatagramErrMsg errMsg;
  GameNetworkingSockets_Init(nullptr, errMsg);
  return 0;
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
  CallReceivedData(Data, Size);
  return 0;  // Non-zero return values are reserved for future use.
}
