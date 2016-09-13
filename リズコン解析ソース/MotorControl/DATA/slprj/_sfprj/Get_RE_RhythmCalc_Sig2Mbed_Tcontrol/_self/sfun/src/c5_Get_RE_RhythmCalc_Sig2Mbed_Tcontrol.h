#ifndef __c5_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_h__
#define __c5_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_h__

/* Include files */
#include "sfc_sf.h"
#include "sfc_mex.h"
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_c5_ResolvedFunctionInfo
#define typedef_c5_ResolvedFunctionInfo

typedef struct {
  const char * context;
  const char * name;
  const char * dominantType;
  const char * resolved;
  uint32_T fileTimeLo;
  uint32_T fileTimeHi;
  uint32_T mFileTimeLo;
  uint32_T mFileTimeHi;
} c5_ResolvedFunctionInfo;

#endif                                 /*typedef_c5_ResolvedFunctionInfo*/

#ifndef typedef_SFc5_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct
#define typedef_SFc5_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint8_T c5_is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
} SFc5_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct;

#endif                                 /*typedef_SFc5_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c5_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_eml_resolved_functions_info
  (void);

/* Function Definitions */
extern void sf_c5_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_check_sum(mxArray
  *plhs[]);
extern void c5_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_method_dispatcher(SimStruct
  *S, int_T method, void *data);

#endif
