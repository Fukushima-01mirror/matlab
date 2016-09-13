/* Include files */

#include <stddef.h>
#include "blas.h"
#include "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_sfun.h"
#include "c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(sfGlobalDebugInstanceStruct,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static const char * c1_debug_family_names[4] = { "MonitorSize", "nargin",
  "nargout", "unused" };

/* Function Declarations */
static void initialize_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void initialize_params_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void enable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void disable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void c1_update_debugger_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static const mxArray *get_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void set_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_st);
static void finalize_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void initSimStructsc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void registerMessagesc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static real_T c1_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static void c1_b_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[4]);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static void c1_info_helper(c1_ResolvedFunctionInfo c1_info[13]);
static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static int32_T c1_c_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static uint8_T c1_d_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_b_is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2, const
   char_T *c1_identifier);
static uint8_T c1_e_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void init_dsm_address_info
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c1_is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2 = 0U;
}

static void initialize_params_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void enable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void c1_update_debugger_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static const mxArray *get_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_y = NULL;
  uint8_T c1_hoistedGlobal;
  uint8_T c1_u;
  const mxArray *c1_b_y = NULL;
  c1_st = NULL;
  c1_st = NULL;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_createcellarray(1), FALSE);
  c1_hoistedGlobal =
    chartInstance->c1_is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  c1_u = c1_hoistedGlobal;
  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", &c1_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c1_y, 0, c1_b_y);
  sf_mex_assign(&c1_st, c1_y, FALSE);
  return c1_st;
}

static void set_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_st)
{
  const mxArray *c1_u;
  chartInstance->c1_doneDoubleBufferReInit = TRUE;
  c1_u = sf_mex_dup(c1_st);
  chartInstance->c1_is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2 =
    c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 0)),
    "is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2");
  sf_mex_destroy(&c1_u);
  c1_update_debugger_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
  real_T c1_hoistedGlobal;
  real_T c1_unused;
  uint32_T c1_debug_family_var_map[4];
  real_T c1_MonitorSize[4];
  real_T c1_nargin = 1.0;
  real_T c1_nargout = 0.0;
  real_T c1_u;
  const mxArray *c1_y = NULL;
  int32_T c1_i0;
  static real_T c1_dv0[4] = { 0.0, 0.0, 500.0, 500.0 };

  int32_T c1_i1;
  static char_T c1_cv0[8] = { 'P', 'o', 's', 'i', 't', 'i', 'o', 'n' };

  char_T c1_b_u[8];
  const mxArray *c1_b_y = NULL;
  int32_T c1_i2;
  real_T c1_c_u[4];
  const mxArray *c1_c_y = NULL;
  real_T c1_d_u;
  const mxArray *c1_d_y = NULL;
  real_T c1_e_u;
  const mxArray *c1_e_y = NULL;
  real_T c1_f_u;
  const mxArray *c1_f_y = NULL;
  char_T c1_g_u;
  const mxArray *c1_g_y = NULL;
  int32_T c1_i3;
  static char_T c1_cv1[10] = { 'M', 'a', 'r', 'k', 'e', 'r', 'S', 'i', 'z', 'e'
  };

  char_T c1_h_u[10];
  const mxArray *c1_h_y = NULL;
  real_T c1_i_u;
  const mxArray *c1_i_y = NULL;
  int32_T c1_i4;
  static char_T c1_cv2[2] = { 'o', 'n' };

  char_T c1_j_u[2];
  const mxArray *c1_j_y = NULL;
  int32_T c1_i5;
  static char_T c1_cv3[6] = { 's', 'q', 'u', 'a', 'r', 'e' };

  char_T c1_k_u[6];
  const mxArray *c1_k_y = NULL;
  real_T c1_l_u;
  const mxArray *c1_l_y = NULL;
  real_T c1_m_u;
  const mxArray *c1_m_y = NULL;
  int32_T c1_i6;
  real_T c1_n_u[2];
  const mxArray *c1_n_y = NULL;
  int32_T c1_i7;
  real_T c1_o_u[2];
  const mxArray *c1_o_y = NULL;
  int32_T c1_i8;
  real_T c1_p_u[2];
  const mxArray *c1_p_y = NULL;
  int32_T c1_i9;
  static char_T c1_cv4[2] = { 'd', 'T' };

  char_T c1_q_u[2];
  const mxArray *c1_q_y = NULL;
  int32_T c1_i10;
  static char_T c1_cv5[4] = { 'd', 'A', '\x81', 'f' };

  char_T c1_r_u[4];
  const mxArray *c1_r_y = NULL;
  real_T *c1_b_unused;
  c1_b_unused = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_DATA_RANGE_CHECK(*c1_b_unused, 0U);
  chartInstance->c1_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  c1_hoistedGlobal = *c1_b_unused;
  c1_unused = c1_hoistedGlobal;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 4U, 4U, c1_debug_family_names,
    c1_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_MonitorSize, 0U, c1_b_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargin, 1U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargout, 2U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_unused, 3U, c1_sf_marshallOut);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 4);
  c1_u = 1.0;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call_debug("figure", 0U, 1U, 14, c1_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 5);
  sf_mex_call_debug("clf", 0U, 0U);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 6);
  for (c1_i0 = 0; c1_i0 < 4; c1_i0++) {
    c1_MonitorSize[c1_i0] = c1_dv0[c1_i0];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 7);
  for (c1_i1 = 0; c1_i1 < 8; c1_i1++) {
    c1_b_u[c1_i1] = c1_cv0[c1_i1];
  }

  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_b_u, 10, 0U, 1U, 0U, 2, 1, 8),
                FALSE);
  for (c1_i2 = 0; c1_i2 < 4; c1_i2++) {
    c1_c_u[c1_i2] = c1_MonitorSize[c1_i2];
  }

  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", c1_c_u, 0, 0U, 1U, 0U, 2, 1, 4),
                FALSE);
  sf_mex_call_debug("set", 0U, 3U, 14, sf_mex_call_debug("gcf", 1U, 0U), 14,
                    c1_b_y, 14, c1_c_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 9);
  c1_d_u = 0.0;
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_d_u, 0, 0U, 0U, 0U, 0), FALSE);
  c1_e_u = 0.0;
  c1_e_y = NULL;
  sf_mex_assign(&c1_e_y, sf_mex_create("y", &c1_e_u, 0, 0U, 0U, 0U, 0), FALSE);
  c1_f_u = 0.0;
  c1_f_y = NULL;
  sf_mex_assign(&c1_f_y, sf_mex_create("y", &c1_f_u, 0, 0U, 0U, 0U, 0), FALSE);
  c1_g_u = '.';
  c1_g_y = NULL;
  sf_mex_assign(&c1_g_y, sf_mex_create("y", &c1_g_u, 10, 0U, 0U, 0U, 0), FALSE);
  for (c1_i3 = 0; c1_i3 < 10; c1_i3++) {
    c1_h_u[c1_i3] = c1_cv1[c1_i3];
  }

  c1_h_y = NULL;
  sf_mex_assign(&c1_h_y, sf_mex_create("y", c1_h_u, 10, 0U, 1U, 0U, 2, 1, 10),
                FALSE);
  c1_i_u = 1.0;
  c1_i_y = NULL;
  sf_mex_assign(&c1_i_y, sf_mex_create("y", &c1_i_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call_debug("plot3", 0U, 6U, 14, c1_d_y, 14, c1_e_y, 14, c1_f_y, 14,
                    c1_g_y, 14, c1_h_y, 14, c1_i_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 10);
  for (c1_i4 = 0; c1_i4 < 2; c1_i4++) {
    c1_j_u[c1_i4] = c1_cv2[c1_i4];
  }

  c1_j_y = NULL;
  sf_mex_assign(&c1_j_y, sf_mex_create("y", c1_j_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call_debug("grid", 0U, 1U, 14, c1_j_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 11);
  for (c1_i5 = 0; c1_i5 < 6; c1_i5++) {
    c1_k_u[c1_i5] = c1_cv3[c1_i5];
  }

  c1_k_y = NULL;
  sf_mex_assign(&c1_k_y, sf_mex_create("y", c1_k_u, 10, 0U, 1U, 0U, 2, 1, 6),
                FALSE);
  sf_mex_call_debug("axis", 0U, 1U, 14, c1_k_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 12);
  c1_l_u = -30.0;
  c1_l_y = NULL;
  sf_mex_assign(&c1_l_y, sf_mex_create("y", &c1_l_u, 0, 0U, 0U, 0U, 0), FALSE);
  c1_m_u = 25.0;
  c1_m_y = NULL;
  sf_mex_assign(&c1_m_y, sf_mex_create("y", &c1_m_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call_debug("view", 0U, 2U, 14, c1_l_y, 14, c1_m_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 13);
  for (c1_i6 = 0; c1_i6 < 2; c1_i6++) {
    c1_n_u[c1_i6] = 600.0 * (real_T)c1_i6;
  }

  c1_n_y = NULL;
  sf_mex_assign(&c1_n_y, sf_mex_create("y", c1_n_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call_debug("xlim", 0U, 1U, 14, c1_n_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 13);
  for (c1_i7 = 0; c1_i7 < 2; c1_i7++) {
    c1_o_u[c1_i7] = 600.0 * (real_T)c1_i7;
  }

  c1_o_y = NULL;
  sf_mex_assign(&c1_o_y, sf_mex_create("y", c1_o_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call_debug("ylim", 0U, 1U, 14, c1_o_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 13);
  for (c1_i8 = 0; c1_i8 < 2; c1_i8++) {
    c1_p_u[c1_i8] = 5000.0 * (real_T)c1_i8;
  }

  c1_p_y = NULL;
  sf_mex_assign(&c1_p_y, sf_mex_create("y", c1_p_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call_debug("zlim", 0U, 1U, 14, c1_p_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 14);
  for (c1_i9 = 0; c1_i9 < 2; c1_i9++) {
    c1_q_u[c1_i9] = c1_cv4[c1_i9];
  }

  c1_q_y = NULL;
  sf_mex_assign(&c1_q_y, sf_mex_create("y", c1_q_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call_debug("xlabel", 0U, 1U, 14, c1_q_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 14);
  for (c1_i10 = 0; c1_i10 < 4; c1_i10++) {
    c1_r_u[c1_i10] = c1_cv5[c1_i10];
  }

  c1_r_y = NULL;
  sf_mex_assign(&c1_r_y, sf_mex_create("y", c1_r_u, 10, 0U, 1U, 0U, 2, 1, 4),
                FALSE);
  sf_mex_call_debug("ylabel", 0U, 1U, 14, c1_r_y);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, -14);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_CHECK_FOR_STATE_INCONSISTENCY
    (_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_,
     chartInstance->chartNumber, chartInstance->instanceNumber);
}

static void initSimStructsc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void registerMessagesc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber)
{
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  real_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(real_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, FALSE);
  return c1_mxArrayOutData;
}

static real_T c1_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_y;
  real_T c1_d0;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_y = c1_d0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_nargout;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y;
  SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    chartInstanceVoid;
  c1_nargout = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_nargout), &c1_thisId);
  sf_mex_destroy(&c1_nargout);
  *(real_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_i11;
  real_T c1_b_inData[4];
  int32_T c1_i12;
  real_T c1_u[4];
  const mxArray *c1_y = NULL;
  SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  for (c1_i11 = 0; c1_i11 < 4; c1_i11++) {
    c1_b_inData[c1_i11] = (*(real_T (*)[4])c1_inData)[c1_i11];
  }

  for (c1_i12 = 0; c1_i12 < 4; c1_i12++) {
    c1_u[c1_i12] = c1_b_inData[c1_i12];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 2, 1, 4), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, FALSE);
  return c1_mxArrayOutData;
}

static void c1_b_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[4])
{
  real_T c1_dv1[4];
  int32_T c1_i13;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_dv1, 1, 0, 0U, 1, 0U, 2, 1, 4);
  for (c1_i13 = 0; c1_i13 < 4; c1_i13++) {
    c1_y[c1_i13] = c1_dv1[c1_i13];
  }

  sf_mex_destroy(&c1_u);
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_MonitorSize;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y[4];
  int32_T c1_i14;
  SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    chartInstanceVoid;
  c1_MonitorSize = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_MonitorSize), &c1_thisId,
                        c1_y);
  sf_mex_destroy(&c1_MonitorSize);
  for (c1_i14 = 0; c1_i14 < 4; c1_i14++) {
    (*(real_T (*)[4])c1_outData)[c1_i14] = c1_y[c1_i14];
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

const mxArray
  *sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c1_nameCaptureInfo;
  c1_ResolvedFunctionInfo c1_info[13];
  const mxArray *c1_m0 = NULL;
  int32_T c1_i15;
  c1_ResolvedFunctionInfo *c1_r0;
  c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  c1_info_helper(c1_info);
  sf_mex_assign(&c1_m0, sf_mex_createstruct("nameCaptureInfo", 1, 13), FALSE);
  for (c1_i15 = 0; c1_i15 < 13; c1_i15++) {
    c1_r0 = &c1_info[c1_i15];
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", c1_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c1_r0->context)), "context", "nameCaptureInfo",
                    c1_i15);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", c1_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c1_r0->name)), "name", "nameCaptureInfo", c1_i15);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", c1_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c1_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c1_i15);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", c1_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c1_r0->resolved)), "resolved", "nameCaptureInfo",
                    c1_i15);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", &c1_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c1_i15);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", &c1_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c1_i15);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", &c1_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c1_i15);
    sf_mex_addfield(c1_m0, sf_mex_create("nameCaptureInfo", &c1_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c1_i15);
  }

  sf_mex_assign(&c1_nameCaptureInfo, c1_m0, FALSE);
  sf_mex_emlrtNameCapturePostProcessR2012a(&c1_nameCaptureInfo);
  return c1_nameCaptureInfo;
}

static void c1_info_helper(c1_ResolvedFunctionInfo c1_info[13])
{
  c1_info[0].context = "";
  c1_info[0].name = "figure";
  c1_info[0].dominantType = "double";
  c1_info[0].resolved = "[IXMB]$matlabroot$/toolbox/matlab/graphics/figure";
  c1_info[0].fileTimeLo = MAX_uint32_T;
  c1_info[0].fileTimeHi = MAX_uint32_T;
  c1_info[0].mFileTimeLo = MAX_uint32_T;
  c1_info[0].mFileTimeHi = MAX_uint32_T;
  c1_info[1].context = "";
  c1_info[1].name = "clf";
  c1_info[1].dominantType = "";
  c1_info[1].resolved = "[IXE]$matlabroot$/toolbox/matlab/graphics/clf.m";
  c1_info[1].fileTimeLo = 1341223548U;
  c1_info[1].fileTimeHi = 0U;
  c1_info[1].mFileTimeLo = 0U;
  c1_info[1].mFileTimeHi = 0U;
  c1_info[2].context = "";
  c1_info[2].name = "gcf";
  c1_info[2].dominantType = "";
  c1_info[2].resolved = "[IXMB]$matlabroot$/toolbox/matlab/graphics/gcf";
  c1_info[2].fileTimeLo = MAX_uint32_T;
  c1_info[2].fileTimeHi = MAX_uint32_T;
  c1_info[2].mFileTimeLo = MAX_uint32_T;
  c1_info[2].mFileTimeHi = MAX_uint32_T;
  c1_info[3].context = "";
  c1_info[3].name = "set";
  c1_info[3].dominantType = "char";
  c1_info[3].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/scomp/set.m";
  c1_info[3].fileTimeLo = 1323141782U;
  c1_info[3].fileTimeHi = 0U;
  c1_info[3].mFileTimeLo = 0U;
  c1_info[3].mFileTimeHi = 0U;
  c1_info[4].context = "";
  c1_info[4].name = "plot3";
  c1_info[4].dominantType = "double";
  c1_info[4].resolved = "[IXMB]$matlabroot$/toolbox/matlab/graph3d/plot3";
  c1_info[4].fileTimeLo = MAX_uint32_T;
  c1_info[4].fileTimeHi = MAX_uint32_T;
  c1_info[4].mFileTimeLo = MAX_uint32_T;
  c1_info[4].mFileTimeHi = MAX_uint32_T;
  c1_info[5].context = "";
  c1_info[5].name = "grid";
  c1_info[5].dominantType = "char";
  c1_info[5].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/grid.m";
  c1_info[5].fileTimeLo = 1311230366U;
  c1_info[5].fileTimeHi = 0U;
  c1_info[5].mFileTimeLo = 0U;
  c1_info[5].mFileTimeHi = 0U;
  c1_info[6].context = "";
  c1_info[6].name = "axis";
  c1_info[6].dominantType = "char";
  c1_info[6].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/axis.m";
  c1_info[6].fileTimeLo = 1344446932U;
  c1_info[6].fileTimeHi = 0U;
  c1_info[6].mFileTimeLo = 0U;
  c1_info[6].mFileTimeHi = 0U;
  c1_info[7].context = "";
  c1_info[7].name = "view";
  c1_info[7].dominantType = "double";
  c1_info[7].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/view.m";
  c1_info[7].fileTimeLo = 1334046560U;
  c1_info[7].fileTimeHi = 0U;
  c1_info[7].mFileTimeLo = 0U;
  c1_info[7].mFileTimeHi = 0U;
  c1_info[8].context = "";
  c1_info[8].name = "xlim";
  c1_info[8].dominantType = "double";
  c1_info[8].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/xlim.m";
  c1_info[8].fileTimeLo = 1299425202U;
  c1_info[8].fileTimeHi = 0U;
  c1_info[8].mFileTimeLo = 0U;
  c1_info[8].mFileTimeHi = 0U;
  c1_info[9].context = "";
  c1_info[9].name = "ylim";
  c1_info[9].dominantType = "double";
  c1_info[9].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/ylim.m";
  c1_info[9].fileTimeLo = 1299425202U;
  c1_info[9].fileTimeHi = 0U;
  c1_info[9].mFileTimeLo = 0U;
  c1_info[9].mFileTimeHi = 0U;
  c1_info[10].context = "";
  c1_info[10].name = "zlim";
  c1_info[10].dominantType = "double";
  c1_info[10].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/zlim.m";
  c1_info[10].fileTimeLo = 1299425202U;
  c1_info[10].fileTimeHi = 0U;
  c1_info[10].mFileTimeLo = 0U;
  c1_info[10].mFileTimeHi = 0U;
  c1_info[11].context = "";
  c1_info[11].name = "xlabel";
  c1_info[11].dominantType = "char";
  c1_info[11].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/xlabel.m";
  c1_info[11].fileTimeLo = 1303531746U;
  c1_info[11].fileTimeHi = 0U;
  c1_info[11].mFileTimeLo = 0U;
  c1_info[11].mFileTimeHi = 0U;
  c1_info[12].context = "";
  c1_info[12].name = "ylabel";
  c1_info[12].dominantType = "char";
  c1_info[12].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/ylabel.m";
  c1_info[12].fileTimeLo = 1303531746U;
  c1_info[12].fileTimeHi = 0U;
  c1_info[12].mFileTimeLo = 0U;
  c1_info[12].mFileTimeHi = 0U;
}

static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(int32_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 6, 0U, 0U, 0U, 0), FALSE);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, FALSE);
  return c1_mxArrayOutData;
}

static int32_T c1_c_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_y;
  int32_T c1_i16;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_i16, 1, 6, 0U, 0, 0U, 0);
  c1_y = c1_i16;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_y;
  SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static uint8_T c1_d_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_b_is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2, const
   char_T *c1_identifier)
{
  uint8_T c1_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2), &c1_thisId);
  sf_mex_destroy(&c1_b_is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2);
  return c1_y;
}

static uint8_T c1_e_emlrt_marshallIn
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance,
   const mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_y;
  uint8_T c1_u0;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u0, 1, 3, 0U, 0, 0U, 0);
  c1_y = c1_u0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void init_dsm_address_info
  (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance)
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

void sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3771590984U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3038154456U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2476377009U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2117364013U);
}

mxArray *sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_autoinheritance_info
  (void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("qCoeYgA6mytBQxCLrXHW3D");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,1,3,dataFields);

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
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

static const mxArray
  *sf_get_sim_state_info_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S'type','srcId','name','auxInfo'{{M[8],M[0],T\"is_active_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 1, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
    chartInstance = (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
      ((ChartInfoStruct *)(ssGetUserData(S)))->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_,
           1,
           1,
           1,
           1,
           0,
           0,
           0,
           0,
           0,
           &(chartInstance->chartNumber),
           &(chartInstance->instanceNumber),
           ssGetPath(S),
           (void *)S);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          init_script_number_translation
            (_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_,
             chartInstance->chartNumber);
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,
             _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,1,1,0,"unused");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,288);
        _SFD_TRANS_COV_WTS(0,0,0,1,0);
        if (chartAlreadyPresent==0) {
          _SFD_TRANS_COV_MAPS(0,
                              0,NULL,NULL,
                              0,NULL,NULL,
                              1,NULL,NULL,
                              0,NULL,NULL);
        }

        _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)NULL);

        {
          real_T *c1_unused;
          c1_unused = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
          _SFD_SET_DATA_VALUE_PTR(0U, c1_unused);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2MachineNumber_,
        chartInstance->chartNumber,chartInstance->instanceNumber);
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "ZbfLrTY9gmeRypkw93DGGD";
}

static void sf_opaque_initialize_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  chart_debug_initialization
    (((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
      chartInstanceVar)->S,0);
  initialize_params_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
  initialize_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_enable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  enable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_disable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  disable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

static void sf_opaque_gateway_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  sf_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct*
  S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2();/* state var info */
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

extern void sf_internal_set_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
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
    sf_get_sim_state_info_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct* S)
{
  return sf_internal_get_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
}

static void sf_opaque_set_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S, st);
}

static void sf_opaque_terminate_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_optimization_info();
    }

    finalize_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
      ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
       chartInstanceVar);
    utFree((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
    ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
     chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
  (SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2
      ((SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct*)
       (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *
  S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,1,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,1,
      "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(S,sf_get_instance_specialization(),infoStruct,1);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,1,1);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=0; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 1; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,1);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(1795565202U));
  ssSetChecksum1(S,(3750653723U));
  ssSetChecksum2(S,(1533224890U));
  ssSetChecksum3(S,(791940576U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(SimStruct *S)
{
  SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *chartInstance;
  chartInstance = (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct *)
    utMalloc(sizeof(SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2InstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW =
    mdlRTW_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2;
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
  chart_debug_initialization(S,1);
}

void c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher(SimStruct *S,
  int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_Get_RE_RhythmCalc_Sig2Mbed_plotdTdAV2_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
