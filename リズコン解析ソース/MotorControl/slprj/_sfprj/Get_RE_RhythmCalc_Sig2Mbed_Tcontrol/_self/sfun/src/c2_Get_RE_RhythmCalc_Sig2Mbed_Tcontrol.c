/* Include files */

#include <stddef.h>
#include "blas.h"
#include "Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_sfun.h"
#include "c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(NULL,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
static void initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void initialize_params_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void enable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void disable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_st);
static void finalize_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void sf_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void initSimStructsc2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void registerMessagesc2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber);
static void c2_info_helper(c2_ResolvedFunctionInfo c2_info[22]);
static real_T c2_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_Axu, const char_T *c2_identifier);
static real_T c2_b_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static uint8_T c2_c_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_b_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol, const char_T *
   c2_identifier);
static uint8_T c2_d_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void init_dsm_address_info
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c2_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol = 0U;
}

static void initialize_params_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

static void enable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static const mxArray *get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  const mxArray *c2_st;
  const mxArray *c2_y = NULL;
  real_T c2_u;
  const mxArray *c2_b_y = NULL;
  real_T c2_b_u;
  const mxArray *c2_c_y = NULL;
  uint8_T c2_c_u;
  const mxArray *c2_d_y = NULL;
  real_T *c2_Axu;
  real_T *c2_Bxu;
  c2_Bxu = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c2_Axu = (real_T *)ssGetOutputPortSignal(chartInstance->S, 1);
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellarray(3), FALSE);
  c2_u = *c2_Axu;
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  c2_b_u = *c2_Bxu;
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_b_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c2_y, 1, c2_c_y);
  c2_c_u = chartInstance->c2_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  c2_d_y = NULL;
  sf_mex_assign(&c2_d_y, sf_mex_create("y", &c2_c_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c2_y, 2, c2_d_y);
  sf_mex_assign(&c2_st, c2_y, FALSE);
  return c2_st;
}

static void set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_st)
{
  const mxArray *c2_u;
  real_T *c2_Axu;
  real_T *c2_Bxu;
  c2_Bxu = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c2_Axu = (real_T *)ssGetOutputPortSignal(chartInstance->S, 1);
  c2_u = sf_mex_dup(c2_st);
  *c2_Axu = c2_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)),
    "Axu");
  *c2_Bxu = c2_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 1)),
    "Bxu");
  chartInstance->c2_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol =
    c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 2)),
    "is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol");
  sf_mex_destroy(&c2_u);
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

static void sf_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  real_T c2_Sx;
  real_T c2_Su;
  int32_T c2_k;
  real_T c2_x[12];
  real_T c2_Sxx;
  real_T c2_Sxu;
  real_T *c2_Bxu;
  real_T *c2_Axu;
  real_T (*c2_X)[12];
  real_T (*c2_u)[12];
  c2_Bxu = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c2_Axu = (real_T *)ssGetOutputPortSignal(chartInstance->S, 1);
  c2_u = (real_T (*)[12])ssGetInputPortSignal(chartInstance->S, 1);
  c2_X = (real_T (*)[12])ssGetInputPortSignal(chartInstance->S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  c2_Sx = (*c2_X)[0];
  c2_Su = (*c2_u)[0];
  for (c2_k = 0; c2_k < 11; c2_k++) {
    c2_Sx += (*c2_X)[c2_k + 1];
    c2_Su += (*c2_u)[c2_k + 1];
  }

  for (c2_k = 0; c2_k < 12; c2_k++) {
    c2_x[c2_k] = (*c2_X)[c2_k] * (*c2_X)[c2_k];
  }

  c2_Sxx = c2_x[0];
  for (c2_k = 0; c2_k < 11; c2_k++) {
    c2_Sxx += c2_x[c2_k + 1];
  }

  for (c2_k = 0; c2_k < 12; c2_k++) {
    c2_x[c2_k] = (*c2_u)[c2_k] * (*c2_X)[c2_k];
  }

  c2_Sxu = c2_x[0];
  for (c2_k = 0; c2_k < 11; c2_k++) {
    c2_Sxu += c2_x[c2_k + 1];
  }

  *c2_Axu = (12.0 * c2_Sxu - c2_Sx * c2_Su) / (12.0 * c2_Sxx - c2_Sx * c2_Sx);
  *c2_Bxu = (c2_Sxx * c2_Su - c2_Sxu * c2_Sx) / (12.0 * c2_Sxx - c2_Sx * c2_Sx);
}

static void initSimStructsc2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

static void registerMessagesc2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber)
{
}

const mxArray
  *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c2_nameCaptureInfo;
  c2_ResolvedFunctionInfo c2_info[22];
  const mxArray *c2_m0 = NULL;
  int32_T c2_i0;
  c2_ResolvedFunctionInfo *c2_r0;
  c2_nameCaptureInfo = NULL;
  c2_info_helper(c2_info);
  sf_mex_assign(&c2_m0, sf_mex_createstruct("nameCaptureInfo", 1, 22), FALSE);
  for (c2_i0 = 0; c2_i0 < 22; c2_i0++) {
    c2_r0 = &c2_info[c2_i0];
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c2_r0->context)), "context", "nameCaptureInfo",
                    c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c2_r0->name)), "name", "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c2_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", c2_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c2_r0->resolved)), "resolved", "nameCaptureInfo",
                    c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c2_i0);
    sf_mex_addfield(c2_m0, sf_mex_create("nameCaptureInfo", &c2_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c2_i0);
  }

  sf_mex_assign(&c2_nameCaptureInfo, c2_m0, FALSE);
  sf_mex_emlrtNameCapturePostProcessR2012a(&c2_nameCaptureInfo);
  return c2_nameCaptureInfo;
}

static void c2_info_helper(c2_ResolvedFunctionInfo c2_info[22])
{
  c2_info[0].context = "";
  c2_info[0].name = "length";
  c2_info[0].dominantType = "double";
  c2_info[0].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/length.m";
  c2_info[0].fileTimeLo = 1303121006U;
  c2_info[0].fileTimeHi = 0U;
  c2_info[0].mFileTimeLo = 0U;
  c2_info[0].mFileTimeHi = 0U;
  c2_info[1].context = "";
  c2_info[1].name = "sum";
  c2_info[1].dominantType = "double";
  c2_info[1].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c2_info[1].fileTimeLo = 1314711412U;
  c2_info[1].fileTimeHi = 0U;
  c2_info[1].mFileTimeLo = 0U;
  c2_info[1].mFileTimeHi = 0U;
  c2_info[2].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c2_info[2].name = "isequal";
  c2_info[2].dominantType = "double";
  c2_info[2].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/isequal.m";
  c2_info[2].fileTimeLo = 1286793558U;
  c2_info[2].fileTimeHi = 0U;
  c2_info[2].mFileTimeLo = 0U;
  c2_info[2].mFileTimeHi = 0U;
  c2_info[3].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/isequal.m";
  c2_info[3].name = "eml_isequal_core";
  c2_info[3].dominantType = "double";
  c2_info[3].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_isequal_core.m";
  c2_info[3].fileTimeLo = 1286793586U;
  c2_info[3].fileTimeHi = 0U;
  c2_info[3].mFileTimeLo = 0U;
  c2_info[3].mFileTimeHi = 0U;
  c2_info[4].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c2_info[4].name = "eml_const_nonsingleton_dim";
  c2_info[4].dominantType = "double";
  c2_info[4].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_const_nonsingleton_dim.m";
  c2_info[4].fileTimeLo = 1286793496U;
  c2_info[4].fileTimeHi = 0U;
  c2_info[4].mFileTimeLo = 0U;
  c2_info[4].mFileTimeHi = 0U;
  c2_info[5].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c2_info[5].name = "eml_scalar_eg";
  c2_info[5].dominantType = "double";
  c2_info[5].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c2_info[5].fileTimeLo = 1286793596U;
  c2_info[5].fileTimeHi = 0U;
  c2_info[5].mFileTimeLo = 0U;
  c2_info[5].mFileTimeHi = 0U;
  c2_info[6].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c2_info[6].name = "eml_index_class";
  c2_info[6].dominantType = "";
  c2_info[6].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_class.m";
  c2_info[6].fileTimeLo = 1323141778U;
  c2_info[6].fileTimeHi = 0U;
  c2_info[6].mFileTimeLo = 0U;
  c2_info[6].mFileTimeHi = 0U;
  c2_info[7].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c2_info[7].name = "eml_int_forloop_overflow_check";
  c2_info[7].dominantType = "";
  c2_info[7].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m";
  c2_info[7].fileTimeLo = 1346485140U;
  c2_info[7].fileTimeHi = 0U;
  c2_info[7].mFileTimeLo = 0U;
  c2_info[7].mFileTimeHi = 0U;
  c2_info[8].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_helper";
  c2_info[8].name = "intmax";
  c2_info[8].dominantType = "char";
  c2_info[8].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/intmax.m";
  c2_info[8].fileTimeLo = 1311230116U;
  c2_info[8].fileTimeHi = 0U;
  c2_info[8].mFileTimeLo = 0U;
  c2_info[8].mFileTimeHi = 0U;
  c2_info[9].context = "";
  c2_info[9].name = "mtimes";
  c2_info[9].dominantType = "double";
  c2_info[9].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[9].fileTimeLo = 1289490892U;
  c2_info[9].fileTimeHi = 0U;
  c2_info[9].mFileTimeLo = 0U;
  c2_info[9].mFileTimeHi = 0U;
  c2_info[10].context = "";
  c2_info[10].name = "mpower";
  c2_info[10].dominantType = "double";
  c2_info[10].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c2_info[10].fileTimeLo = 1286793642U;
  c2_info[10].fileTimeHi = 0U;
  c2_info[10].mFileTimeLo = 0U;
  c2_info[10].mFileTimeHi = 0U;
  c2_info[11].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c2_info[11].name = "power";
  c2_info[11].dominantType = "double";
  c2_info[11].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c2_info[11].fileTimeLo = 1348166730U;
  c2_info[11].fileTimeHi = 0U;
  c2_info[11].mFileTimeLo = 0U;
  c2_info[11].mFileTimeHi = 0U;
  c2_info[12].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c2_info[12].name = "eml_scalar_eg";
  c2_info[12].dominantType = "double";
  c2_info[12].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c2_info[12].fileTimeLo = 1286793596U;
  c2_info[12].fileTimeHi = 0U;
  c2_info[12].mFileTimeLo = 0U;
  c2_info[12].mFileTimeHi = 0U;
  c2_info[13].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c2_info[13].name = "eml_scalexp_alloc";
  c2_info[13].dominantType = "double";
  c2_info[13].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m";
  c2_info[13].fileTimeLo = 1352396060U;
  c2_info[13].fileTimeHi = 0U;
  c2_info[13].mFileTimeLo = 0U;
  c2_info[13].mFileTimeHi = 0U;
  c2_info[14].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c2_info[14].name = "floor";
  c2_info[14].dominantType = "double";
  c2_info[14].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m";
  c2_info[14].fileTimeLo = 1343805180U;
  c2_info[14].fileTimeHi = 0U;
  c2_info[14].mFileTimeLo = 0U;
  c2_info[14].mFileTimeHi = 0U;
  c2_info[15].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m";
  c2_info[15].name = "eml_scalar_floor";
  c2_info[15].dominantType = "double";
  c2_info[15].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_floor.m";
  c2_info[15].fileTimeLo = 1286793526U;
  c2_info[15].fileTimeHi = 0U;
  c2_info[15].mFileTimeLo = 0U;
  c2_info[15].mFileTimeHi = 0U;
  c2_info[16].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power";
  c2_info[16].name = "eml_scalar_eg";
  c2_info[16].dominantType = "double";
  c2_info[16].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c2_info[16].fileTimeLo = 1286793596U;
  c2_info[16].fileTimeHi = 0U;
  c2_info[16].mFileTimeLo = 0U;
  c2_info[16].mFileTimeHi = 0U;
  c2_info[17].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power";
  c2_info[17].name = "mtimes";
  c2_info[17].dominantType = "double";
  c2_info[17].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c2_info[17].fileTimeLo = 1289490892U;
  c2_info[17].fileTimeHi = 0U;
  c2_info[17].mFileTimeLo = 0U;
  c2_info[17].mFileTimeHi = 0U;
  c2_info[18].context = "";
  c2_info[18].name = "mrdivide";
  c2_info[18].dominantType = "double";
  c2_info[18].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c2_info[18].fileTimeLo = 1357922748U;
  c2_info[18].fileTimeHi = 0U;
  c2_info[18].mFileTimeLo = 1319704766U;
  c2_info[18].mFileTimeHi = 0U;
  c2_info[19].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c2_info[19].name = "rdivide";
  c2_info[19].dominantType = "double";
  c2_info[19].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[19].fileTimeLo = 1346485188U;
  c2_info[19].fileTimeHi = 0U;
  c2_info[19].mFileTimeLo = 0U;
  c2_info[19].mFileTimeHi = 0U;
  c2_info[20].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[20].name = "eml_scalexp_compatible";
  c2_info[20].dominantType = "double";
  c2_info[20].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_compatible.m";
  c2_info[20].fileTimeLo = 1286793596U;
  c2_info[20].fileTimeHi = 0U;
  c2_info[20].mFileTimeLo = 0U;
  c2_info[20].mFileTimeHi = 0U;
  c2_info[21].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c2_info[21].name = "eml_div";
  c2_info[21].dominantType = "double";
  c2_info[21].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_div.m";
  c2_info[21].fileTimeLo = 1313322610U;
  c2_info[21].fileTimeHi = 0U;
  c2_info[21].mFileTimeLo = 0U;
  c2_info[21].mFileTimeHi = 0U;
}

static real_T c2_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_Axu, const char_T *c2_identifier)
{
  real_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_Axu), &c2_thisId);
  sf_mex_destroy(&c2_Axu);
  return c2_y;
}

static real_T c2_b_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  real_T c2_y;
  real_T c2_d0;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_d0, 1, 0, 0U, 0, 0U, 0);
  c2_y = c2_d0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static uint8_T c2_c_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_b_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol, const char_T *
   c2_identifier)
{
  uint8_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol);
  return c2_y;
}

static uint8_T c2_d_emlrt_marshallIn
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_y;
  uint8_T c2_u0;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_u0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void init_dsm_address_info
  (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(263677088U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(270195679U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2568656638U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(4210720204U);
}

mxArray *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("Xrz2a5oPmZD2didNXDb9UD");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(12);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(12);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

static const mxArray
  *sf_get_sim_state_info_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x3'type','srcId','name','auxInfo'{{M[1],M[6],T\"Axu\",},{M[1],M[12],T\"Bxu\",},{M[8],M[0],T\"is_active_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 3, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "m5cExFghLIigpHDoRJNJCD";
}

static void sf_opaque_initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  initialize_params_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
  initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  enable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  disable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  sf_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct* S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_raw2high'.\n");
  }

  return plhs[0];
}

extern void sf_internal_set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SimStruct* S, const mxArray *st)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_high2raw");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = mxDuplicateArray(st);      /* high level simctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct* S)
{
  return sf_internal_get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S);
}

static void sf_opaque_set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S, st);
}

static void sf_opaque_terminate_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_optimization_info();
    }

    finalize_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
      ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
       chartInstanceVar);
    utFree((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
      ((SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
       (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,2,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,2,
      "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(S,sf_get_instance_specialization(),infoStruct,2);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,2,2);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,2,2);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=2; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 2; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,2);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(1368531470U));
  ssSetChecksum1(S,(1477659913U));
  ssSetChecksum2(S,(4035503262U));
  ssSetChecksum3(S,(646304296U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct *S)
{
  SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance;
  chartInstance = (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *)
    utMalloc(sizeof(SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc2_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW =
    mdlRTW_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->S = S;
  ssSetUserData(S,(void *)(&(chartInstance->chartInfo)));/* register the chart instance with simstruct */
  init_dsm_address_info(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  sf_opaque_init_subchart_simstructs(chartInstance->chartInfo.chartInstance);
}

void c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_method_dispatcher(SimStruct *S,
  int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
