/* Include files */

#include <stddef.h>
#include "blas.h"
#include "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_sfun.h"
#include "c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2.h"
#include "mwmathutil.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(NULL,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
static void initialize_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void initialize_params_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void enable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void disable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static const mxArray *get_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void set_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_st);
static void finalize_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void initSimStructsc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void registerMessagesc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c5_machineNumber, uint32_T
  c5_chartNumber);
static void c5_info_helper(c5_ResolvedFunctionInfo c5_info[25]);
static void c5_eml_error
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static real_T c5_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_A12, const char_T *c5_identifier);
static real_T c5_b_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_u, const emlrtMsgIdentifier *c5_parentId);
static void c5_c_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_X1, const char_T *c5_identifier, real_T c5_y[12]);
static void c5_d_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_u, const emlrtMsgIdentifier *c5_parentId, real_T c5_y[12]);
static uint8_T c5_e_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_b_is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2, const
   char_T *c5_identifier);
static uint8_T c5_f_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_u, const emlrtMsgIdentifier *c5_parentId);
static void init_dsm_address_info
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c5_is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2 = 0U;
}

static void initialize_params_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void enable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static const mxArray *get_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  const mxArray *c5_st;
  const mxArray *c5_y = NULL;
  real_T c5_u;
  const mxArray *c5_b_y = NULL;
  real_T c5_b_u;
  const mxArray *c5_c_y = NULL;
  int32_T c5_i0;
  real_T c5_c_u[12];
  const mxArray *c5_d_y = NULL;
  uint8_T c5_d_u;
  const mxArray *c5_e_y = NULL;
  real_T *c5_A12;
  real_T *c5_B12;
  real_T (*c5_X1)[12];
  c5_B12 = (real_T *)ssGetOutputPortSignal(chartInstance->S, 3);
  c5_A12 = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c5_X1 = (real_T (*)[12])ssGetOutputPortSignal(chartInstance->S, 1);
  c5_st = NULL;
  c5_y = NULL;
  sf_mex_assign(&c5_y, sf_mex_createcellarray(4), FALSE);
  c5_u = *c5_A12;
  c5_b_y = NULL;
  sf_mex_assign(&c5_b_y, sf_mex_create("y", &c5_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c5_y, 0, c5_b_y);
  c5_b_u = *c5_B12;
  c5_c_y = NULL;
  sf_mex_assign(&c5_c_y, sf_mex_create("y", &c5_b_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c5_y, 1, c5_c_y);
  for (c5_i0 = 0; c5_i0 < 12; c5_i0++) {
    c5_c_u[c5_i0] = (*c5_X1)[c5_i0];
  }

  c5_d_y = NULL;
  sf_mex_assign(&c5_d_y, sf_mex_create("y", c5_c_u, 0, 0U, 1U, 0U, 1, 12), FALSE);
  sf_mex_setcell(c5_y, 2, c5_d_y);
  c5_d_u = chartInstance->c5_is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  c5_e_y = NULL;
  sf_mex_assign(&c5_e_y, sf_mex_create("y", &c5_d_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c5_y, 3, c5_e_y);
  sf_mex_assign(&c5_st, c5_y, FALSE);
  return c5_st;
}

static void set_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_st)
{
  const mxArray *c5_u;
  real_T *c5_A12;
  real_T *c5_B12;
  real_T (*c5_X1)[12];
  c5_B12 = (real_T *)ssGetOutputPortSignal(chartInstance->S, 3);
  c5_A12 = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c5_X1 = (real_T (*)[12])ssGetOutputPortSignal(chartInstance->S, 1);
  c5_u = sf_mex_dup(c5_st);
  *c5_A12 = c5_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c5_u, 0)),
    "A12");
  *c5_B12 = c5_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c5_u, 1)),
    "B12");
  c5_c_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c5_u, 2)), "X1",
                        *c5_X1);
  chartInstance->c5_is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2 =
    c5_e_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c5_u, 3)),
    "is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2");
  sf_mex_destroy(&c5_u);
  sf_mex_destroy(&c5_st);
}

static void finalize_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  real_T c5_S1;
  real_T c5_S2;
  int32_T c5_k;
  real_T c5_x[12];
  real_T c5_S11;
  real_T c5_S12;
  real_T c5_k2;
  real_T c5_k1;
  real_T *c5_B12;
  real_T *c5_A12;
  real_T (*c5_X1)[12];
  real_T (*c5_u1)[12];
  real_T (*c5_u2)[12];
  c5_B12 = (real_T *)ssGetOutputPortSignal(chartInstance->S, 3);
  c5_A12 = (real_T *)ssGetOutputPortSignal(chartInstance->S, 2);
  c5_X1 = (real_T (*)[12])ssGetOutputPortSignal(chartInstance->S, 1);
  c5_u2 = (real_T (*)[12])ssGetInputPortSignal(chartInstance->S, 1);
  c5_u1 = (real_T (*)[12])ssGetInputPortSignal(chartInstance->S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  c5_S1 = (*c5_u1)[0];
  c5_S2 = (*c5_u2)[0];
  for (c5_k = 0; c5_k < 11; c5_k++) {
    c5_S1 += (*c5_u1)[c5_k + 1];
    c5_S2 += (*c5_u2)[c5_k + 1];
  }

  for (c5_k = 0; c5_k < 12; c5_k++) {
    c5_x[c5_k] = (*c5_u1)[c5_k] * (*c5_u1)[c5_k];
  }

  c5_S11 = c5_x[0];
  for (c5_k = 0; c5_k < 11; c5_k++) {
    c5_S11 += c5_x[c5_k + 1];
  }

  for (c5_k = 0; c5_k < 12; c5_k++) {
    c5_x[c5_k] = (*c5_u1)[c5_k] * (*c5_u2)[c5_k];
  }

  c5_S12 = c5_x[0];
  for (c5_k = 0; c5_k < 11; c5_k++) {
    c5_S12 += c5_x[c5_k + 1];
  }

  *c5_A12 = (12.0 * c5_S12 - c5_S1 * c5_S2) / (12.0 * c5_S11 - c5_S1 * c5_S1);
  c5_k2 = *c5_A12 * *c5_A12;
  if (1.0 + c5_k2 < 0.0) {
    c5_eml_error(chartInstance);
  }

  c5_k1 = 1.0 / muDoubleScalarSqrt(1.0 + c5_k2);
  c5_k2 = *c5_A12 * *c5_A12;
  if (1.0 + c5_k2 < 0.0) {
    c5_eml_error(chartInstance);
  }

  c5_k2 = *c5_A12 / muDoubleScalarSqrt(1.0 + c5_k2);
  *c5_B12 = (c5_S11 * c5_S2 - c5_S12 * c5_S1) / (12.0 * c5_S11 - c5_S1 * c5_S1);
  for (c5_k = 0; c5_k < 12; c5_k++) {
    (*c5_X1)[c5_k] = c5_k1 * (*c5_u1)[c5_k] + c5_k2 * ((*c5_u2)[c5_k] - *c5_B12);
  }
}

static void initSimStructsc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void registerMessagesc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c5_machineNumber, uint32_T
  c5_chartNumber)
{
}

const mxArray
  *sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c5_nameCaptureInfo;
  c5_ResolvedFunctionInfo c5_info[25];
  const mxArray *c5_m0 = NULL;
  int32_T c5_i1;
  c5_ResolvedFunctionInfo *c5_r0;
  c5_nameCaptureInfo = NULL;
  c5_info_helper(c5_info);
  sf_mex_assign(&c5_m0, sf_mex_createstruct("nameCaptureInfo", 1, 25), FALSE);
  for (c5_i1 = 0; c5_i1 < 25; c5_i1++) {
    c5_r0 = &c5_info[c5_i1];
    sf_mex_addfield(c5_m0, sf_mex_create("nameCaptureInfo", c5_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c5_r0->context)), "context", "nameCaptureInfo",
                    c5_i1);
    sf_mex_addfield(c5_m0, sf_mex_create("nameCaptureInfo", c5_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c5_r0->name)), "name", "nameCaptureInfo", c5_i1);
    sf_mex_addfield(c5_m0, sf_mex_create("nameCaptureInfo", c5_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c5_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c5_i1);
    sf_mex_addfield(c5_m0, sf_mex_create("nameCaptureInfo", c5_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c5_r0->resolved)), "resolved", "nameCaptureInfo",
                    c5_i1);
    sf_mex_addfield(c5_m0, sf_mex_create("nameCaptureInfo", &c5_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c5_i1);
    sf_mex_addfield(c5_m0, sf_mex_create("nameCaptureInfo", &c5_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c5_i1);
    sf_mex_addfield(c5_m0, sf_mex_create("nameCaptureInfo", &c5_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c5_i1);
    sf_mex_addfield(c5_m0, sf_mex_create("nameCaptureInfo", &c5_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c5_i1);
  }

  sf_mex_assign(&c5_nameCaptureInfo, c5_m0, FALSE);
  sf_mex_emlrtNameCapturePostProcessR2012a(&c5_nameCaptureInfo);
  return c5_nameCaptureInfo;
}

static void c5_info_helper(c5_ResolvedFunctionInfo c5_info[25])
{
  c5_info[0].context = "";
  c5_info[0].name = "length";
  c5_info[0].dominantType = "double";
  c5_info[0].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/length.m";
  c5_info[0].fileTimeLo = 1303121006U;
  c5_info[0].fileTimeHi = 0U;
  c5_info[0].mFileTimeLo = 0U;
  c5_info[0].mFileTimeHi = 0U;
  c5_info[1].context = "";
  c5_info[1].name = "sum";
  c5_info[1].dominantType = "double";
  c5_info[1].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c5_info[1].fileTimeLo = 1314711412U;
  c5_info[1].fileTimeHi = 0U;
  c5_info[1].mFileTimeLo = 0U;
  c5_info[1].mFileTimeHi = 0U;
  c5_info[2].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c5_info[2].name = "isequal";
  c5_info[2].dominantType = "double";
  c5_info[2].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/isequal.m";
  c5_info[2].fileTimeLo = 1286793558U;
  c5_info[2].fileTimeHi = 0U;
  c5_info[2].mFileTimeLo = 0U;
  c5_info[2].mFileTimeHi = 0U;
  c5_info[3].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/isequal.m";
  c5_info[3].name = "eml_isequal_core";
  c5_info[3].dominantType = "double";
  c5_info[3].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_isequal_core.m";
  c5_info[3].fileTimeLo = 1286793586U;
  c5_info[3].fileTimeHi = 0U;
  c5_info[3].mFileTimeLo = 0U;
  c5_info[3].mFileTimeHi = 0U;
  c5_info[4].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c5_info[4].name = "eml_const_nonsingleton_dim";
  c5_info[4].dominantType = "double";
  c5_info[4].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_const_nonsingleton_dim.m";
  c5_info[4].fileTimeLo = 1286793496U;
  c5_info[4].fileTimeHi = 0U;
  c5_info[4].mFileTimeLo = 0U;
  c5_info[4].mFileTimeHi = 0U;
  c5_info[5].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c5_info[5].name = "eml_scalar_eg";
  c5_info[5].dominantType = "double";
  c5_info[5].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c5_info[5].fileTimeLo = 1286793596U;
  c5_info[5].fileTimeHi = 0U;
  c5_info[5].mFileTimeLo = 0U;
  c5_info[5].mFileTimeHi = 0U;
  c5_info[6].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c5_info[6].name = "eml_index_class";
  c5_info[6].dominantType = "";
  c5_info[6].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_class.m";
  c5_info[6].fileTimeLo = 1323141778U;
  c5_info[6].fileTimeHi = 0U;
  c5_info[6].mFileTimeLo = 0U;
  c5_info[6].mFileTimeHi = 0U;
  c5_info[7].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/sum.m";
  c5_info[7].name = "eml_int_forloop_overflow_check";
  c5_info[7].dominantType = "";
  c5_info[7].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m";
  c5_info[7].fileTimeLo = 1346485140U;
  c5_info[7].fileTimeHi = 0U;
  c5_info[7].mFileTimeLo = 0U;
  c5_info[7].mFileTimeHi = 0U;
  c5_info[8].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_helper";
  c5_info[8].name = "intmax";
  c5_info[8].dominantType = "char";
  c5_info[8].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/intmax.m";
  c5_info[8].fileTimeLo = 1311230116U;
  c5_info[8].fileTimeHi = 0U;
  c5_info[8].mFileTimeLo = 0U;
  c5_info[8].mFileTimeHi = 0U;
  c5_info[9].context = "";
  c5_info[9].name = "mtimes";
  c5_info[9].dominantType = "double";
  c5_info[9].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c5_info[9].fileTimeLo = 1289490892U;
  c5_info[9].fileTimeHi = 0U;
  c5_info[9].mFileTimeLo = 0U;
  c5_info[9].mFileTimeHi = 0U;
  c5_info[10].context = "";
  c5_info[10].name = "mpower";
  c5_info[10].dominantType = "double";
  c5_info[10].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c5_info[10].fileTimeLo = 1286793642U;
  c5_info[10].fileTimeHi = 0U;
  c5_info[10].mFileTimeLo = 0U;
  c5_info[10].mFileTimeHi = 0U;
  c5_info[11].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c5_info[11].name = "power";
  c5_info[11].dominantType = "double";
  c5_info[11].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c5_info[11].fileTimeLo = 1348166730U;
  c5_info[11].fileTimeHi = 0U;
  c5_info[11].mFileTimeLo = 0U;
  c5_info[11].mFileTimeHi = 0U;
  c5_info[12].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c5_info[12].name = "eml_scalar_eg";
  c5_info[12].dominantType = "double";
  c5_info[12].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c5_info[12].fileTimeLo = 1286793596U;
  c5_info[12].fileTimeHi = 0U;
  c5_info[12].mFileTimeLo = 0U;
  c5_info[12].mFileTimeHi = 0U;
  c5_info[13].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c5_info[13].name = "eml_scalexp_alloc";
  c5_info[13].dominantType = "double";
  c5_info[13].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m";
  c5_info[13].fileTimeLo = 1352396060U;
  c5_info[13].fileTimeHi = 0U;
  c5_info[13].mFileTimeLo = 0U;
  c5_info[13].mFileTimeHi = 0U;
  c5_info[14].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c5_info[14].name = "floor";
  c5_info[14].dominantType = "double";
  c5_info[14].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m";
  c5_info[14].fileTimeLo = 1343805180U;
  c5_info[14].fileTimeHi = 0U;
  c5_info[14].mFileTimeLo = 0U;
  c5_info[14].mFileTimeHi = 0U;
  c5_info[15].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m";
  c5_info[15].name = "eml_scalar_floor";
  c5_info[15].dominantType = "double";
  c5_info[15].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_floor.m";
  c5_info[15].fileTimeLo = 1286793526U;
  c5_info[15].fileTimeHi = 0U;
  c5_info[15].mFileTimeLo = 0U;
  c5_info[15].mFileTimeHi = 0U;
  c5_info[16].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power";
  c5_info[16].name = "eml_scalar_eg";
  c5_info[16].dominantType = "double";
  c5_info[16].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c5_info[16].fileTimeLo = 1286793596U;
  c5_info[16].fileTimeHi = 0U;
  c5_info[16].mFileTimeLo = 0U;
  c5_info[16].mFileTimeHi = 0U;
  c5_info[17].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power";
  c5_info[17].name = "mtimes";
  c5_info[17].dominantType = "double";
  c5_info[17].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c5_info[17].fileTimeLo = 1289490892U;
  c5_info[17].fileTimeHi = 0U;
  c5_info[17].mFileTimeLo = 0U;
  c5_info[17].mFileTimeHi = 0U;
  c5_info[18].context = "";
  c5_info[18].name = "mrdivide";
  c5_info[18].dominantType = "double";
  c5_info[18].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c5_info[18].fileTimeLo = 1357922748U;
  c5_info[18].fileTimeHi = 0U;
  c5_info[18].mFileTimeLo = 1319704766U;
  c5_info[18].mFileTimeHi = 0U;
  c5_info[19].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c5_info[19].name = "rdivide";
  c5_info[19].dominantType = "double";
  c5_info[19].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c5_info[19].fileTimeLo = 1346485188U;
  c5_info[19].fileTimeHi = 0U;
  c5_info[19].mFileTimeLo = 0U;
  c5_info[19].mFileTimeHi = 0U;
  c5_info[20].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c5_info[20].name = "eml_scalexp_compatible";
  c5_info[20].dominantType = "double";
  c5_info[20].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_compatible.m";
  c5_info[20].fileTimeLo = 1286793596U;
  c5_info[20].fileTimeHi = 0U;
  c5_info[20].mFileTimeLo = 0U;
  c5_info[20].mFileTimeHi = 0U;
  c5_info[21].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c5_info[21].name = "eml_div";
  c5_info[21].dominantType = "double";
  c5_info[21].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_div.m";
  c5_info[21].fileTimeLo = 1313322610U;
  c5_info[21].fileTimeHi = 0U;
  c5_info[21].mFileTimeLo = 0U;
  c5_info[21].mFileTimeHi = 0U;
  c5_info[22].context = "";
  c5_info[22].name = "sqrt";
  c5_info[22].dominantType = "double";
  c5_info[22].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m";
  c5_info[22].fileTimeLo = 1343805186U;
  c5_info[22].fileTimeHi = 0U;
  c5_info[22].mFileTimeLo = 0U;
  c5_info[22].mFileTimeHi = 0U;
  c5_info[23].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m";
  c5_info[23].name = "eml_error";
  c5_info[23].dominantType = "char";
  c5_info[23].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_error.m";
  c5_info[23].fileTimeLo = 1343805158U;
  c5_info[23].fileTimeHi = 0U;
  c5_info[23].mFileTimeLo = 0U;
  c5_info[23].mFileTimeHi = 0U;
  c5_info[24].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m";
  c5_info[24].name = "eml_scalar_sqrt";
  c5_info[24].dominantType = "double";
  c5_info[24].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_sqrt.m";
  c5_info[24].fileTimeLo = 1286793538U;
  c5_info[24].fileTimeHi = 0U;
  c5_info[24].mFileTimeLo = 0U;
  c5_info[24].mFileTimeHi = 0U;
}

static void c5_eml_error
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  int32_T c5_i2;
  static char_T c5_cv0[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o', 'l',
    'b', 'o', 'x', ':', 'E', 'l', 'F', 'u', 'n', 'D', 'o', 'm', 'a', 'i', 'n',
    'E', 'r', 'r', 'o', 'r' };

  char_T c5_u[30];
  const mxArray *c5_y = NULL;
  static char_T c5_cv1[4] = { 's', 'q', 'r', 't' };

  char_T c5_b_u[4];
  const mxArray *c5_b_y = NULL;
  for (c5_i2 = 0; c5_i2 < 30; c5_i2++) {
    c5_u[c5_i2] = c5_cv0[c5_i2];
  }

  c5_y = NULL;
  sf_mex_assign(&c5_y, sf_mex_create("y", c5_u, 10, 0U, 1U, 0U, 2, 1, 30), FALSE);
  for (c5_i2 = 0; c5_i2 < 4; c5_i2++) {
    c5_b_u[c5_i2] = c5_cv1[c5_i2];
  }

  c5_b_y = NULL;
  sf_mex_assign(&c5_b_y, sf_mex_create("y", c5_b_u, 10, 0U, 1U, 0U, 2, 1, 4),
                FALSE);
  sf_mex_call("error", 0U, 1U, 14, sf_mex_call("message", 1U, 2U, 14, c5_y, 14,
    c5_b_y));
}

static real_T c5_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_A12, const char_T *c5_identifier)
{
  real_T c5_y;
  emlrtMsgIdentifier c5_thisId;
  c5_thisId.fIdentifier = c5_identifier;
  c5_thisId.fParent = NULL;
  c5_y = c5_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c5_A12), &c5_thisId);
  sf_mex_destroy(&c5_A12);
  return c5_y;
}

static real_T c5_b_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_u, const emlrtMsgIdentifier *c5_parentId)
{
  real_T c5_y;
  real_T c5_d0;
  sf_mex_import(c5_parentId, sf_mex_dup(c5_u), &c5_d0, 1, 0, 0U, 0, 0U, 0);
  c5_y = c5_d0;
  sf_mex_destroy(&c5_u);
  return c5_y;
}

static void c5_c_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_X1, const char_T *c5_identifier, real_T c5_y[12])
{
  emlrtMsgIdentifier c5_thisId;
  c5_thisId.fIdentifier = c5_identifier;
  c5_thisId.fParent = NULL;
  c5_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c5_X1), &c5_thisId, c5_y);
  sf_mex_destroy(&c5_X1);
}

static void c5_d_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_u, const emlrtMsgIdentifier *c5_parentId, real_T c5_y[12])
{
  real_T c5_dv0[12];
  int32_T c5_i3;
  sf_mex_import(c5_parentId, sf_mex_dup(c5_u), c5_dv0, 1, 0, 0U, 1, 0U, 1, 12);
  for (c5_i3 = 0; c5_i3 < 12; c5_i3++) {
    c5_y[c5_i3] = c5_dv0[c5_i3];
  }

  sf_mex_destroy(&c5_u);
}

static uint8_T c5_e_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_b_is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2, const
   char_T *c5_identifier)
{
  uint8_T c5_y;
  emlrtMsgIdentifier c5_thisId;
  c5_thisId.fIdentifier = c5_identifier;
  c5_thisId.fParent = NULL;
  c5_y = c5_f_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c5_b_is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2), &c5_thisId);
  sf_mex_destroy(&c5_b_is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2);
  return c5_y;
}

static uint8_T c5_f_emlrt_marshallIn
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c5_u, const emlrtMsgIdentifier *c5_parentId)
{
  uint8_T c5_y;
  uint8_T c5_u0;
  sf_mex_import(c5_parentId, sf_mex_dup(c5_u), &c5_u0, 1, 3, 0U, 0, 0U, 0);
  c5_y = c5_u0;
  sf_mex_destroy(&c5_u);
  return c5_y;
}

static void init_dsm_address_info
  (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
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

void sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2955755889U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(154967188U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2589226452U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1440646473U);
}

mxArray *sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
  (void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("h2XjLU4SWHkzQEotZl66aD");
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

    mxArray *mxData = mxCreateStructMatrix(1,3,3,dataFields);

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

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,2,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,2,"type",mxType);
    }

    mxSetField(mxData,2,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

static const mxArray
  *sf_get_sim_state_info_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x4'type','srcId','name','auxInfo'{{M[1],M[21],T\"A12\",},{M[1],M[22],T\"B12\",},{M[1],M[14],T\"X1\",},{M[8],M[0],T\"is_active_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 4, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "CVEryNKHetbvSrLbrls";
}

static void sf_opaque_initialize_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  initialize_params_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
  initialize_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_enable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  enable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_disable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  disable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_gateway_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  sf_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct*
  S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2();/* state var info */
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

extern void sf_internal_set_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
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
    sf_get_sim_state_info_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct* S)
{
  return sf_internal_get_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
}

static void sf_opaque_set_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S, st);
}

static void sf_opaque_terminate_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_optimization_info();
    }

    finalize_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
      ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
       chartInstanceVar);
    utFree((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
      ((SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
       (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *
  S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      5);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,5,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,5,
      "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(S,sf_get_instance_specialization(),infoStruct,5);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,5,2);
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,5,3);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=3; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 2; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,5);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(1421860681U));
  ssSetChecksum1(S,(2944707888U));
  ssSetChecksum2(S,(994787002U));
  ssSetChecksum3(S,(2589355898U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *S)
{
  SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    utMalloc(sizeof(SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW =
    mdlRTW_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
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

void c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher(SimStruct *S,
  int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c5_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
