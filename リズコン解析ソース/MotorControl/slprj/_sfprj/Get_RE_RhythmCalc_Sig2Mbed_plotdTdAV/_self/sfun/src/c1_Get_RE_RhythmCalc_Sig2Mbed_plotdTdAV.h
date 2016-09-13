#ifndef __c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_h__
#define __c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_h__

/* Include files */
#include "sfc_sf.h"
#include "sfc_mex.h"
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_c1_ResolvedFunctionInfo
#define typedef_c1_ResolvedFunctionInfo

typedef struct {
  const char * context;
  const char * name;
  const char * dominantType;
  const char * resolved;
  uint32_T fileTimeLo;
  uint32_T fileTimeHi;
  uint32_T mFileTimeLo;
  uint32_T mFileTimeHi;
} c1_ResolvedFunctionInfo;

#endif                                 /*typedef_c1_ResolvedFunctionInfo*/

#ifndef typedef_SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct
#define typedef_SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c1_sfEvent;
  boolean_T c1_isStable;
  boolean_T c1_doneDoubleBufferReInit;
  uint8_T c1_is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV;
} SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct;

#endif                                 /*typedef_SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAVInstanceStruct*/

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray
  *sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_get_eml_resolved_functions_info
  (void);

/* Function Definitions */
extern void sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_get_check_sum(mxArray
  *plhs[]);
extern void c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV_method_dispatcher(SimStruct *
  S, int_T method, void *data);

#endif
