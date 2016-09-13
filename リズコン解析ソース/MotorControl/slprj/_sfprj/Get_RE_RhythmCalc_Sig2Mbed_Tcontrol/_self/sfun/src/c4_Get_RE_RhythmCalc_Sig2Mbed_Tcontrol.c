/* Include files */

#include <stddef.h>
#include "blas.h"
#include "Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_sfun.h"
#include "c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol.h"
#include "mwmathutil.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(NULL,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
static void initialize_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void initialize_params_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void enable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void disable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void set_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c4_st);
static void finalize_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void sf_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void initSimStructsc4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void registerMessagesc4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c4_machineNumber, uint32_T
  c4_chartNumber);
static void c4_info_helper(c4_ResolvedFunctionInfo c4_info[38]);
static void c4_eml_error(SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *
  chartInstance);
static uint8_T c4_emlrt_marshallIn
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c4_b_is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol, const char_T *
   c4_identifier);
static uint8_T c4_b_emlrt_marshallIn
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c4_u, const emlrtMsgIdentifier *c4_parentId);
static void init_dsm_address_info
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  chartInstance->c4_is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol = 0U;
}

static void initialize_params_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

static void enable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static void disable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
}

static const mxArray *get_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  const mxArray *c4_st = NULL;
  const mxArray *c4_y = NULL;
  uint8_T c4_u;
  const mxArray *c4_b_y = NULL;
  c4_st = NULL;
  c4_y = NULL;
  sf_mex_assign(&c4_y, sf_mex_createcellarray(1), FALSE);
  c4_u = chartInstance->c4_is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  c4_b_y = NULL;
  sf_mex_assign(&c4_b_y, sf_mex_create("y", &c4_u, 3, 0U, 0U, 0U, 0), FALSE);
  sf_mex_setcell(c4_y, 0, c4_b_y);
  sf_mex_assign(&c4_st, c4_y, FALSE);
  return c4_st;
}

static void set_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c4_st)
{
  const mxArray *c4_u;
  c4_u = sf_mex_dup(c4_st);
  chartInstance->c4_is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol =
    c4_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c4_u, 0)),
                        "is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol");
  sf_mex_destroy(&c4_u);
  sf_mex_destroy(&c4_st);
}

static void finalize_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

static void sf_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
  int32_T c4_ixstart;
  real_T c4_u[12];
  const mxArray *c4_y = NULL;
  real_T c4_b_u[12];
  const mxArray *c4_b_y = NULL;
  real_T c4_c_u[12];
  const mxArray *c4_c_y = NULL;
  char_T c4_d_u;
  const mxArray *c4_d_y = NULL;
  static char_T c4_cv0[10] = { 'M', 'a', 'r', 'k', 'e', 'r', 'S', 'i', 'z', 'e'
  };

  char_T c4_e_u[10];
  const mxArray *c4_e_y = NULL;
  real_T c4_f_u;
  const mxArray *c4_f_y = NULL;
  real_T c4_k2;
  real_T c4_k1;
  real_T c4_varargin_1[12];
  real_T c4_mtmp;
  int32_T c4_ix;
  boolean_T c4_exitg1;
  static char_T c4_cv1[2] = { 'o', 'n' };

  char_T c4_g_u[2];
  const mxArray *c4_g_y = NULL;
  real_T c4_dv0[2];
  real_T c4_h_u[2];
  const mxArray *c4_h_y = NULL;
  real_T c4_dv1[2];
  real_T c4_i_u[2];
  const mxArray *c4_i_y = NULL;
  real_T c4_j_u[2];
  const mxArray *c4_j_y = NULL;
  char_T c4_k_u;
  const mxArray *c4_k_y = NULL;
  real_T c4_l_u[2];
  const mxArray *c4_l_y = NULL;
  real_T c4_dv2[2];
  real_T c4_m_u[2];
  const mxArray *c4_m_y = NULL;
  real_T c4_dv3[2];
  real_T c4_n_u[2];
  const mxArray *c4_n_y = NULL;
  char_T c4_o_u;
  const mxArray *c4_o_y = NULL;
  static char_T c4_cv2[9] = { 'L', 'i', 'n', 'e', 'W', 'i', 'd', 't', 'h' };

  char_T c4_p_u[9];
  const mxArray *c4_p_y = NULL;
  real_T c4_q_u;
  const mxArray *c4_q_y = NULL;
  static char_T c4_cv3[3] = { 'o', 'f', 'f' };

  char_T c4_r_u[3];
  const mxArray *c4_r_y = NULL;
  char_T c4_s_u[2];
  const mxArray *c4_s_y = NULL;
  static char_T c4_cv4[6] = { 's', 'q', 'u', 'a', 'r', 'e' };

  char_T c4_t_u[6];
  const mxArray *c4_t_y = NULL;
  real_T c4_u_u;
  const mxArray *c4_u_y = NULL;
  real_T c4_v_u;
  const mxArray *c4_v_y = NULL;
  real_T c4_w_u[2];
  const mxArray *c4_w_y = NULL;
  real_T c4_x_u[2];
  const mxArray *c4_x_y = NULL;
  real_T c4_y_u[2];
  const mxArray *c4_y_y = NULL;
  static char_T c4_cv5[2] = { 'd', 'T' };

  char_T c4_ab_u[2];
  const mxArray *c4_ab_y = NULL;
  static char_T c4_cv6[2] = { 'd', 'A' };

  char_T c4_bb_u[2];
  const mxArray *c4_bb_y = NULL;
  real_T *c4_A12;
  real_T *c4_B12;
  real_T *c4_Axu;
  real_T *c4_Bxu;
  real_T (*c4_u1)[12];
  real_T (*c4_u2)[12];
  real_T (*c4_cb_u)[12];
  c4_Bxu = (real_T *)ssGetInputPortSignal(chartInstance->S, 6);
  c4_Axu = (real_T *)ssGetInputPortSignal(chartInstance->S, 5);
  c4_B12 = (real_T *)ssGetInputPortSignal(chartInstance->S, 4);
  c4_A12 = (real_T *)ssGetInputPortSignal(chartInstance->S, 3);
  c4_u2 = (real_T (*)[12])ssGetInputPortSignal(chartInstance->S, 2);
  c4_u1 = (real_T (*)[12])ssGetInputPortSignal(chartInstance->S, 1);
  c4_cb_u = (real_T (*)[12])ssGetInputPortSignal(chartInstance->S, 0);
  _sfTime_ = (real_T)ssGetT(chartInstance->S);
  for (c4_ixstart = 0; c4_ixstart < 12; c4_ixstart++) {
    c4_u[c4_ixstart] = (*c4_u1)[c4_ixstart];
  }

  c4_y = NULL;
  sf_mex_assign(&c4_y, sf_mex_create("y", c4_u, 0, 0U, 1U, 0U, 1, 12), FALSE);
  for (c4_ixstart = 0; c4_ixstart < 12; c4_ixstart++) {
    c4_b_u[c4_ixstart] = (*c4_u2)[c4_ixstart];
  }

  c4_b_y = NULL;
  sf_mex_assign(&c4_b_y, sf_mex_create("y", c4_b_u, 0, 0U, 1U, 0U, 1, 12), FALSE);
  for (c4_ixstart = 0; c4_ixstart < 12; c4_ixstart++) {
    c4_c_u[c4_ixstart] = (*c4_cb_u)[c4_ixstart];
  }

  c4_c_y = NULL;
  sf_mex_assign(&c4_c_y, sf_mex_create("y", c4_c_u, 0, 0U, 1U, 0U, 1, 12), FALSE);
  c4_d_u = 'o';
  c4_d_y = NULL;
  sf_mex_assign(&c4_d_y, sf_mex_create("y", &c4_d_u, 10, 0U, 0U, 0U, 0), FALSE);
  for (c4_ixstart = 0; c4_ixstart < 10; c4_ixstart++) {
    c4_e_u[c4_ixstart] = c4_cv0[c4_ixstart];
  }

  c4_e_y = NULL;
  sf_mex_assign(&c4_e_y, sf_mex_create("y", c4_e_u, 10, 0U, 1U, 0U, 2, 1, 10),
                FALSE);
  c4_f_u = 2.0;
  c4_f_y = NULL;
  sf_mex_assign(&c4_f_y, sf_mex_create("y", &c4_f_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call("plot3", 0U, 6U, 14, c4_y, 14, c4_b_y, 14, c4_c_y, 14, c4_d_y, 14,
              c4_e_y, 14, c4_f_y);
  c4_k2 = *c4_A12 * *c4_A12;
  if (1.0 + c4_k2 < 0.0) {
    c4_eml_error(chartInstance);
  }

  c4_k1 = 1.0 / muDoubleScalarSqrt(1.0 + c4_k2);
  c4_k2 = *c4_A12 * *c4_A12;
  if (1.0 + c4_k2 < 0.0) {
    c4_eml_error(chartInstance);
  }

  c4_k2 = *c4_A12 / muDoubleScalarSqrt(1.0 + c4_k2);
  for (c4_ixstart = 0; c4_ixstart < 12; c4_ixstart++) {
    c4_varargin_1[c4_ixstart] = c4_k1 * (*c4_u1)[c4_ixstart] + c4_k2 * ((*c4_u2)
      [c4_ixstart] - *c4_B12);
  }

  c4_ixstart = 1;
  c4_mtmp = c4_varargin_1[0];
  if (muDoubleScalarIsNaN(c4_varargin_1[0])) {
    c4_ix = 2;
    c4_exitg1 = FALSE;
    while ((c4_exitg1 == FALSE) && (c4_ix < 13)) {
      c4_ixstart = c4_ix;
      if (!muDoubleScalarIsNaN(c4_varargin_1[c4_ix - 1])) {
        c4_mtmp = c4_varargin_1[c4_ix - 1];
        c4_exitg1 = TRUE;
      } else {
        c4_ix++;
      }
    }
  }

  if (c4_ixstart < 12) {
    while (c4_ixstart + 1 < 13) {
      if (c4_varargin_1[c4_ixstart] > c4_mtmp) {
        c4_mtmp = c4_varargin_1[c4_ixstart];
      }

      c4_ixstart++;
    }
  }

  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_g_u[c4_ixstart] = c4_cv1[c4_ixstart];
  }

  c4_g_y = NULL;
  sf_mex_assign(&c4_g_y, sf_mex_create("y", c4_g_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("hold", 0U, 1U, 14, c4_g_y);
  c4_dv0[0] = 0.0;
  c4_dv0[1] = c4_k1;
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_h_u[c4_ixstart] = 500.0 * c4_dv0[c4_ixstart];
  }

  c4_h_y = NULL;
  sf_mex_assign(&c4_h_y, sf_mex_create("y", c4_h_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  c4_dv1[0] = 0.0;
  c4_dv1[1] = c4_k2;
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_i_u[c4_ixstart] = 500.0 * c4_dv1[c4_ixstart] + *c4_B12;
  }

  c4_i_y = NULL;
  sf_mex_assign(&c4_i_y, sf_mex_create("y", c4_i_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_j_u[c4_ixstart] = 0.0;
  }

  c4_j_y = NULL;
  sf_mex_assign(&c4_j_y, sf_mex_create("y", c4_j_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  c4_k_u = 'r';
  c4_k_y = NULL;
  sf_mex_assign(&c4_k_y, sf_mex_create("y", &c4_k_u, 10, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call("plot3", 0U, 4U, 14, c4_h_y, 14, c4_i_y, 14, c4_j_y, 14, c4_k_y);
  c4_l_u[0] = 0.0;
  c4_l_u[1] = c4_mtmp * c4_k1;
  c4_l_y = NULL;
  sf_mex_assign(&c4_l_y, sf_mex_create("y", c4_l_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  c4_dv2[0] = 0.0;
  c4_dv2[1] = c4_mtmp * c4_k2;
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_m_u[c4_ixstart] = c4_dv2[c4_ixstart] + *c4_B12;
  }

  c4_m_y = NULL;
  sf_mex_assign(&c4_m_y, sf_mex_create("y", c4_m_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  c4_dv3[0] = 0.0;
  c4_dv3[1] = *c4_Axu * c4_mtmp;
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_n_u[c4_ixstart] = c4_dv3[c4_ixstart] + *c4_Bxu;
  }

  c4_n_y = NULL;
  sf_mex_assign(&c4_n_y, sf_mex_create("y", c4_n_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  c4_o_u = 'r';
  c4_o_y = NULL;
  sf_mex_assign(&c4_o_y, sf_mex_create("y", &c4_o_u, 10, 0U, 0U, 0U, 0), FALSE);
  for (c4_ixstart = 0; c4_ixstart < 9; c4_ixstart++) {
    c4_p_u[c4_ixstart] = c4_cv2[c4_ixstart];
  }

  c4_p_y = NULL;
  sf_mex_assign(&c4_p_y, sf_mex_create("y", c4_p_u, 10, 0U, 1U, 0U, 2, 1, 9),
                FALSE);
  c4_q_u = 3.0;
  c4_q_y = NULL;
  sf_mex_assign(&c4_q_y, sf_mex_create("y", &c4_q_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call("plot3", 0U, 6U, 14, c4_l_y, 14, c4_m_y, 14, c4_n_y, 14, c4_o_y,
              14, c4_p_y, 14, c4_q_y);
  for (c4_ixstart = 0; c4_ixstart < 3; c4_ixstart++) {
    c4_r_u[c4_ixstart] = c4_cv3[c4_ixstart];
  }

  c4_r_y = NULL;
  sf_mex_assign(&c4_r_y, sf_mex_create("y", c4_r_u, 10, 0U, 1U, 0U, 2, 1, 3),
                FALSE);
  sf_mex_call("hold", 0U, 1U, 14, c4_r_y);
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_s_u[c4_ixstart] = c4_cv1[c4_ixstart];
  }

  c4_s_y = NULL;
  sf_mex_assign(&c4_s_y, sf_mex_create("y", c4_s_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("grid", 0U, 1U, 14, c4_s_y);
  for (c4_ixstart = 0; c4_ixstart < 6; c4_ixstart++) {
    c4_t_u[c4_ixstart] = c4_cv4[c4_ixstart];
  }

  c4_t_y = NULL;
  sf_mex_assign(&c4_t_y, sf_mex_create("y", c4_t_u, 10, 0U, 1U, 0U, 2, 1, 6),
                FALSE);
  sf_mex_call("axis", 0U, 1U, 14, c4_t_y);
  c4_u_u = -30.0;
  c4_u_y = NULL;
  sf_mex_assign(&c4_u_y, sf_mex_create("y", &c4_u_u, 0, 0U, 0U, 0U, 0), FALSE);
  c4_v_u = 25.0;
  c4_v_y = NULL;
  sf_mex_assign(&c4_v_y, sf_mex_create("y", &c4_v_u, 0, 0U, 0U, 0U, 0), FALSE);
  sf_mex_call("view", 0U, 2U, 14, c4_u_y, 14, c4_v_y);
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_w_u[c4_ixstart] = 600.0 * (real_T)c4_ixstart;
  }

  c4_w_y = NULL;
  sf_mex_assign(&c4_w_y, sf_mex_create("y", c4_w_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("xlim", 0U, 1U, 14, c4_w_y);
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_x_u[c4_ixstart] = 600.0 * (real_T)c4_ixstart;
  }

  c4_x_y = NULL;
  sf_mex_assign(&c4_x_y, sf_mex_create("y", c4_x_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("ylim", 0U, 1U, 14, c4_x_y);
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_y_u[c4_ixstart] = 5000.0 * (real_T)c4_ixstart;
  }

  c4_y_y = NULL;
  sf_mex_assign(&c4_y_y, sf_mex_create("y", c4_y_u, 0, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("zlim", 0U, 1U, 14, c4_y_y);
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_ab_u[c4_ixstart] = c4_cv5[c4_ixstart];
  }

  c4_ab_y = NULL;
  sf_mex_assign(&c4_ab_y, sf_mex_create("y", c4_ab_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("xlabel", 0U, 1U, 14, c4_ab_y);
  for (c4_ixstart = 0; c4_ixstart < 2; c4_ixstart++) {
    c4_bb_u[c4_ixstart] = c4_cv6[c4_ixstart];
  }

  c4_bb_y = NULL;
  sf_mex_assign(&c4_bb_y, sf_mex_create("y", c4_bb_u, 10, 0U, 1U, 0U, 2, 1, 2),
                FALSE);
  sf_mex_call("ylabel", 0U, 1U, 14, c4_bb_y);
}

static void initSimStructsc4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

static void registerMessagesc4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
{
}

static void init_script_number_translation(uint32_T c4_machineNumber, uint32_T
  c4_chartNumber)
{
}

const mxArray
  *sf_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_eml_resolved_functions_info
  (void)
{
  const mxArray *c4_nameCaptureInfo;
  c4_ResolvedFunctionInfo c4_info[38];
  const mxArray *c4_m0 = NULL;
  int32_T c4_i0;
  c4_ResolvedFunctionInfo *c4_r0;
  c4_nameCaptureInfo = NULL;
  c4_info_helper(c4_info);
  sf_mex_assign(&c4_m0, sf_mex_createstruct("nameCaptureInfo", 1, 38), FALSE);
  for (c4_i0 = 0; c4_i0 < 38; c4_i0++) {
    c4_r0 = &c4_info[c4_i0];
    sf_mex_addfield(c4_m0, sf_mex_create("nameCaptureInfo", c4_r0->context, 15,
      0U, 0U, 0U, 2, 1, strlen(c4_r0->context)), "context", "nameCaptureInfo",
                    c4_i0);
    sf_mex_addfield(c4_m0, sf_mex_create("nameCaptureInfo", c4_r0->name, 15, 0U,
      0U, 0U, 2, 1, strlen(c4_r0->name)), "name", "nameCaptureInfo", c4_i0);
    sf_mex_addfield(c4_m0, sf_mex_create("nameCaptureInfo", c4_r0->dominantType,
      15, 0U, 0U, 0U, 2, 1, strlen(c4_r0->dominantType)), "dominantType",
                    "nameCaptureInfo", c4_i0);
    sf_mex_addfield(c4_m0, sf_mex_create("nameCaptureInfo", c4_r0->resolved, 15,
      0U, 0U, 0U, 2, 1, strlen(c4_r0->resolved)), "resolved", "nameCaptureInfo",
                    c4_i0);
    sf_mex_addfield(c4_m0, sf_mex_create("nameCaptureInfo", &c4_r0->fileTimeLo,
      7, 0U, 0U, 0U, 0), "fileTimeLo", "nameCaptureInfo", c4_i0);
    sf_mex_addfield(c4_m0, sf_mex_create("nameCaptureInfo", &c4_r0->fileTimeHi,
      7, 0U, 0U, 0U, 0), "fileTimeHi", "nameCaptureInfo", c4_i0);
    sf_mex_addfield(c4_m0, sf_mex_create("nameCaptureInfo", &c4_r0->mFileTimeLo,
      7, 0U, 0U, 0U, 0), "mFileTimeLo", "nameCaptureInfo", c4_i0);
    sf_mex_addfield(c4_m0, sf_mex_create("nameCaptureInfo", &c4_r0->mFileTimeHi,
      7, 0U, 0U, 0U, 0), "mFileTimeHi", "nameCaptureInfo", c4_i0);
  }

  sf_mex_assign(&c4_nameCaptureInfo, c4_m0, FALSE);
  sf_mex_emlrtNameCapturePostProcessR2012a(&c4_nameCaptureInfo);
  return c4_nameCaptureInfo;
}

static void c4_info_helper(c4_ResolvedFunctionInfo c4_info[38])
{
  c4_info[0].context = "";
  c4_info[0].name = "plot3";
  c4_info[0].dominantType = "double";
  c4_info[0].resolved = "[IXMB]$matlabroot$/toolbox/matlab/graph3d/plot3";
  c4_info[0].fileTimeLo = MAX_uint32_T;
  c4_info[0].fileTimeHi = MAX_uint32_T;
  c4_info[0].mFileTimeLo = MAX_uint32_T;
  c4_info[0].mFileTimeHi = MAX_uint32_T;
  c4_info[1].context = "";
  c4_info[1].name = "mpower";
  c4_info[1].dominantType = "double";
  c4_info[1].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c4_info[1].fileTimeLo = 1286793642U;
  c4_info[1].fileTimeHi = 0U;
  c4_info[1].mFileTimeLo = 0U;
  c4_info[1].mFileTimeHi = 0U;
  c4_info[2].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mpower.m";
  c4_info[2].name = "power";
  c4_info[2].dominantType = "double";
  c4_info[2].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m";
  c4_info[2].fileTimeLo = 1348166730U;
  c4_info[2].fileTimeHi = 0U;
  c4_info[2].mFileTimeLo = 0U;
  c4_info[2].mFileTimeHi = 0U;
  c4_info[3].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c4_info[3].name = "eml_scalar_eg";
  c4_info[3].dominantType = "double";
  c4_info[3].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c4_info[3].fileTimeLo = 1286793596U;
  c4_info[3].fileTimeHi = 0U;
  c4_info[3].mFileTimeLo = 0U;
  c4_info[3].mFileTimeHi = 0U;
  c4_info[4].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c4_info[4].name = "eml_scalexp_alloc";
  c4_info[4].dominantType = "double";
  c4_info[4].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_alloc.m";
  c4_info[4].fileTimeLo = 1352396060U;
  c4_info[4].fileTimeHi = 0U;
  c4_info[4].mFileTimeLo = 0U;
  c4_info[4].mFileTimeHi = 0U;
  c4_info[5].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!fltpower";
  c4_info[5].name = "floor";
  c4_info[5].dominantType = "double";
  c4_info[5].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m";
  c4_info[5].fileTimeLo = 1343805180U;
  c4_info[5].fileTimeHi = 0U;
  c4_info[5].mFileTimeLo = 0U;
  c4_info[5].mFileTimeHi = 0U;
  c4_info[6].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/floor.m";
  c4_info[6].name = "eml_scalar_floor";
  c4_info[6].dominantType = "double";
  c4_info[6].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_floor.m";
  c4_info[6].fileTimeLo = 1286793526U;
  c4_info[6].fileTimeHi = 0U;
  c4_info[6].mFileTimeLo = 0U;
  c4_info[6].mFileTimeHi = 0U;
  c4_info[7].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power";
  c4_info[7].name = "eml_scalar_eg";
  c4_info[7].dominantType = "double";
  c4_info[7].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c4_info[7].fileTimeLo = 1286793596U;
  c4_info[7].fileTimeHi = 0U;
  c4_info[7].mFileTimeLo = 0U;
  c4_info[7].mFileTimeHi = 0U;
  c4_info[8].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power";
  c4_info[8].name = "mtimes";
  c4_info[8].dominantType = "double";
  c4_info[8].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c4_info[8].fileTimeLo = 1289490892U;
  c4_info[8].fileTimeHi = 0U;
  c4_info[8].mFileTimeLo = 0U;
  c4_info[8].mFileTimeHi = 0U;
  c4_info[9].context = "";
  c4_info[9].name = "sqrt";
  c4_info[9].dominantType = "double";
  c4_info[9].resolved = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m";
  c4_info[9].fileTimeLo = 1343805186U;
  c4_info[9].fileTimeHi = 0U;
  c4_info[9].mFileTimeLo = 0U;
  c4_info[9].mFileTimeHi = 0U;
  c4_info[10].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m";
  c4_info[10].name = "eml_error";
  c4_info[10].dominantType = "char";
  c4_info[10].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_error.m";
  c4_info[10].fileTimeLo = 1343805158U;
  c4_info[10].fileTimeHi = 0U;
  c4_info[10].mFileTimeLo = 0U;
  c4_info[10].mFileTimeHi = 0U;
  c4_info[11].context = "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/sqrt.m";
  c4_info[11].name = "eml_scalar_sqrt";
  c4_info[11].dominantType = "double";
  c4_info[11].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elfun/eml_scalar_sqrt.m";
  c4_info[11].fileTimeLo = 1286793538U;
  c4_info[11].fileTimeHi = 0U;
  c4_info[11].mFileTimeLo = 0U;
  c4_info[11].mFileTimeHi = 0U;
  c4_info[12].context = "";
  c4_info[12].name = "mrdivide";
  c4_info[12].dominantType = "double";
  c4_info[12].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c4_info[12].fileTimeLo = 1357922748U;
  c4_info[12].fileTimeHi = 0U;
  c4_info[12].mFileTimeLo = 1319704766U;
  c4_info[12].mFileTimeHi = 0U;
  c4_info[13].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mrdivide.p";
  c4_info[13].name = "rdivide";
  c4_info[13].dominantType = "double";
  c4_info[13].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c4_info[13].fileTimeLo = 1346485188U;
  c4_info[13].fileTimeHi = 0U;
  c4_info[13].mFileTimeLo = 0U;
  c4_info[13].mFileTimeHi = 0U;
  c4_info[14].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c4_info[14].name = "eml_scalexp_compatible";
  c4_info[14].dominantType = "double";
  c4_info[14].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalexp_compatible.m";
  c4_info[14].fileTimeLo = 1286793596U;
  c4_info[14].fileTimeHi = 0U;
  c4_info[14].mFileTimeLo = 0U;
  c4_info[14].mFileTimeHi = 0U;
  c4_info[15].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/rdivide.m";
  c4_info[15].name = "eml_div";
  c4_info[15].dominantType = "double";
  c4_info[15].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_div.m";
  c4_info[15].fileTimeLo = 1313322610U;
  c4_info[15].fileTimeHi = 0U;
  c4_info[15].mFileTimeLo = 0U;
  c4_info[15].mFileTimeHi = 0U;
  c4_info[16].context = "";
  c4_info[16].name = "mtimes";
  c4_info[16].dominantType = "double";
  c4_info[16].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/ops/mtimes.m";
  c4_info[16].fileTimeLo = 1289490892U;
  c4_info[16].fileTimeHi = 0U;
  c4_info[16].mFileTimeLo = 0U;
  c4_info[16].mFileTimeHi = 0U;
  c4_info[17].context = "";
  c4_info[17].name = "max";
  c4_info[17].dominantType = "double";
  c4_info[17].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/max.m";
  c4_info[17].fileTimeLo = 1311230116U;
  c4_info[17].fileTimeHi = 0U;
  c4_info[17].mFileTimeLo = 0U;
  c4_info[17].mFileTimeHi = 0U;
  c4_info[18].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/datafun/max.m";
  c4_info[18].name = "eml_min_or_max";
  c4_info[18].dominantType = "char";
  c4_info[18].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m";
  c4_info[18].fileTimeLo = 1334046290U;
  c4_info[18].fileTimeHi = 0U;
  c4_info[18].mFileTimeLo = 0U;
  c4_info[18].mFileTimeHi = 0U;
  c4_info[19].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m!eml_extremum";
  c4_info[19].name = "eml_const_nonsingleton_dim";
  c4_info[19].dominantType = "double";
  c4_info[19].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_const_nonsingleton_dim.m";
  c4_info[19].fileTimeLo = 1286793496U;
  c4_info[19].fileTimeHi = 0U;
  c4_info[19].mFileTimeLo = 0U;
  c4_info[19].mFileTimeHi = 0U;
  c4_info[20].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m!eml_extremum";
  c4_info[20].name = "eml_scalar_eg";
  c4_info[20].dominantType = "double";
  c4_info[20].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_scalar_eg.m";
  c4_info[20].fileTimeLo = 1286793596U;
  c4_info[20].fileTimeHi = 0U;
  c4_info[20].mFileTimeLo = 0U;
  c4_info[20].mFileTimeHi = 0U;
  c4_info[21].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m!eml_extremum";
  c4_info[21].name = "eml_index_class";
  c4_info[21].dominantType = "";
  c4_info[21].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_class.m";
  c4_info[21].fileTimeLo = 1323141778U;
  c4_info[21].fileTimeHi = 0U;
  c4_info[21].mFileTimeLo = 0U;
  c4_info[21].mFileTimeHi = 0U;
  c4_info[22].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m!eml_extremum_sub";
  c4_info[22].name = "eml_index_class";
  c4_info[22].dominantType = "";
  c4_info[22].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_class.m";
  c4_info[22].fileTimeLo = 1323141778U;
  c4_info[22].fileTimeHi = 0U;
  c4_info[22].mFileTimeLo = 0U;
  c4_info[22].mFileTimeHi = 0U;
  c4_info[23].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m!eml_extremum_sub";
  c4_info[23].name = "isnan";
  c4_info[23].dominantType = "double";
  c4_info[23].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/isnan.m";
  c4_info[23].fileTimeLo = 1286793560U;
  c4_info[23].fileTimeHi = 0U;
  c4_info[23].mFileTimeLo = 0U;
  c4_info[23].mFileTimeHi = 0U;
  c4_info[24].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m!eml_extremum_sub";
  c4_info[24].name = "eml_index_plus";
  c4_info[24].dominantType = "coder.internal.indexInt";
  c4_info[24].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_plus.m";
  c4_info[24].fileTimeLo = 1286793578U;
  c4_info[24].fileTimeHi = 0U;
  c4_info[24].mFileTimeLo = 0U;
  c4_info[24].mFileTimeHi = 0U;
  c4_info[25].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_plus.m";
  c4_info[25].name = "eml_index_class";
  c4_info[25].dominantType = "";
  c4_info[25].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_index_class.m";
  c4_info[25].fileTimeLo = 1323141778U;
  c4_info[25].fileTimeHi = 0U;
  c4_info[25].mFileTimeLo = 0U;
  c4_info[25].mFileTimeHi = 0U;
  c4_info[26].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m!eml_extremum_sub";
  c4_info[26].name = "eml_int_forloop_overflow_check";
  c4_info[26].dominantType = "";
  c4_info[26].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m";
  c4_info[26].fileTimeLo = 1346485140U;
  c4_info[26].fileTimeHi = 0U;
  c4_info[26].mFileTimeLo = 0U;
  c4_info[26].mFileTimeHi = 0U;
  c4_info[27].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_helper";
  c4_info[27].name = "intmax";
  c4_info[27].dominantType = "char";
  c4_info[27].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/elmat/intmax.m";
  c4_info[27].fileTimeLo = 1311230116U;
  c4_info[27].fileTimeHi = 0U;
  c4_info[27].mFileTimeLo = 0U;
  c4_info[27].mFileTimeHi = 0U;
  c4_info[28].context =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_min_or_max.m!eml_extremum_sub";
  c4_info[28].name = "eml_relop";
  c4_info[28].dominantType = "function_handle";
  c4_info[28].resolved =
    "[ILXE]$matlabroot$/toolbox/eml/lib/matlab/eml/eml_relop.m";
  c4_info[28].fileTimeLo = 1342425982U;
  c4_info[28].fileTimeHi = 0U;
  c4_info[28].mFileTimeLo = 0U;
  c4_info[28].mFileTimeHi = 0U;
  c4_info[29].context = "";
  c4_info[29].name = "hold";
  c4_info[29].dominantType = "char";
  c4_info[29].resolved = "[IXE]$matlabroot$/toolbox/matlab/graphics/hold.m";
  c4_info[29].fileTimeLo = 1305011098U;
  c4_info[29].fileTimeHi = 0U;
  c4_info[29].mFileTimeLo = 0U;
  c4_info[29].mFileTimeHi = 0U;
  c4_info[30].context = "";
  c4_info[30].name = "grid";
  c4_info[30].dominantType = "char";
  c4_info[30].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/grid.m";
  c4_info[30].fileTimeLo = 1311230366U;
  c4_info[30].fileTimeHi = 0U;
  c4_info[30].mFileTimeLo = 0U;
  c4_info[30].mFileTimeHi = 0U;
  c4_info[31].context = "";
  c4_info[31].name = "axis";
  c4_info[31].dominantType = "char";
  c4_info[31].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/axis.m";
  c4_info[31].fileTimeLo = 1344446932U;
  c4_info[31].fileTimeHi = 0U;
  c4_info[31].mFileTimeLo = 0U;
  c4_info[31].mFileTimeHi = 0U;
  c4_info[32].context = "";
  c4_info[32].name = "view";
  c4_info[32].dominantType = "double";
  c4_info[32].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/view.m";
  c4_info[32].fileTimeLo = 1334046560U;
  c4_info[32].fileTimeHi = 0U;
  c4_info[32].mFileTimeLo = 0U;
  c4_info[32].mFileTimeHi = 0U;
  c4_info[33].context = "";
  c4_info[33].name = "xlim";
  c4_info[33].dominantType = "double";
  c4_info[33].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/xlim.m";
  c4_info[33].fileTimeLo = 1299425202U;
  c4_info[33].fileTimeHi = 0U;
  c4_info[33].mFileTimeLo = 0U;
  c4_info[33].mFileTimeHi = 0U;
  c4_info[34].context = "";
  c4_info[34].name = "ylim";
  c4_info[34].dominantType = "double";
  c4_info[34].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/ylim.m";
  c4_info[34].fileTimeLo = 1299425202U;
  c4_info[34].fileTimeHi = 0U;
  c4_info[34].mFileTimeLo = 0U;
  c4_info[34].mFileTimeHi = 0U;
  c4_info[35].context = "";
  c4_info[35].name = "zlim";
  c4_info[35].dominantType = "double";
  c4_info[35].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph3d/zlim.m";
  c4_info[35].fileTimeLo = 1299425202U;
  c4_info[35].fileTimeHi = 0U;
  c4_info[35].mFileTimeLo = 0U;
  c4_info[35].mFileTimeHi = 0U;
  c4_info[36].context = "";
  c4_info[36].name = "xlabel";
  c4_info[36].dominantType = "char";
  c4_info[36].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/xlabel.m";
  c4_info[36].fileTimeLo = 1303531746U;
  c4_info[36].fileTimeHi = 0U;
  c4_info[36].mFileTimeLo = 0U;
  c4_info[36].mFileTimeHi = 0U;
  c4_info[37].context = "";
  c4_info[37].name = "ylabel";
  c4_info[37].dominantType = "char";
  c4_info[37].resolved = "[IXE]$matlabroot$/toolbox/matlab/graph2d/ylabel.m";
  c4_info[37].fileTimeLo = 1303531746U;
  c4_info[37].fileTimeHi = 0U;
  c4_info[37].mFileTimeLo = 0U;
  c4_info[37].mFileTimeHi = 0U;
}

static void c4_eml_error(SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *
  chartInstance)
{
  int32_T c4_i1;
  static char_T c4_cv7[30] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o', 'l',
    'b', 'o', 'x', ':', 'E', 'l', 'F', 'u', 'n', 'D', 'o', 'm', 'a', 'i', 'n',
    'E', 'r', 'r', 'o', 'r' };

  char_T c4_u[30];
  const mxArray *c4_y = NULL;
  static char_T c4_cv8[4] = { 's', 'q', 'r', 't' };

  char_T c4_b_u[4];
  const mxArray *c4_b_y = NULL;
  for (c4_i1 = 0; c4_i1 < 30; c4_i1++) {
    c4_u[c4_i1] = c4_cv7[c4_i1];
  }

  c4_y = NULL;
  sf_mex_assign(&c4_y, sf_mex_create("y", c4_u, 10, 0U, 1U, 0U, 2, 1, 30), FALSE);
  for (c4_i1 = 0; c4_i1 < 4; c4_i1++) {
    c4_b_u[c4_i1] = c4_cv8[c4_i1];
  }

  c4_b_y = NULL;
  sf_mex_assign(&c4_b_y, sf_mex_create("y", c4_b_u, 10, 0U, 1U, 0U, 2, 1, 4),
                FALSE);
  sf_mex_call("error", 0U, 1U, 14, sf_mex_call("message", 1U, 2U, 14, c4_y, 14,
    c4_b_y));
}

static uint8_T c4_emlrt_marshallIn
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c4_b_is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol, const char_T *
   c4_identifier)
{
  uint8_T c4_y;
  emlrtMsgIdentifier c4_thisId;
  c4_thisId.fIdentifier = c4_identifier;
  c4_thisId.fParent = NULL;
  c4_y = c4_b_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c4_b_is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol), &c4_thisId);
  sf_mex_destroy(&c4_b_is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol);
  return c4_y;
}

static uint8_T c4_b_emlrt_marshallIn
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance, const
   mxArray *c4_u, const emlrtMsgIdentifier *c4_parentId)
{
  uint8_T c4_y;
  uint8_T c4_u0;
  sf_mex_import(c4_parentId, sf_mex_dup(c4_u), &c4_u0, 1, 3, 0U, 0, 0U, 0);
  c4_y = c4_u0;
  sf_mex_destroy(&c4_u);
  return c4_y;
}

static void init_dsm_address_info
  (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance)
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

void sf_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(4210997657U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1927937671U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(27893362U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1693616065U);
}

mxArray *sf_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("IICsO7vkDsCwPTda11nHiB");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,7,3,dataFields);

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

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(12);
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

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,3,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,3,"type",mxType);
    }

    mxSetField(mxData,3,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,4,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,4,"type",mxType);
    }

    mxSetField(mxData,4,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,5,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,5,"type",mxType);
    }

    mxSetField(mxData,5,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
      pr[1] = (double)(1);
      mxSetField(mxData,6,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,6,"type",mxType);
    }

    mxSetField(mxData,6,"complexity",mxCreateDoubleScalar(0));
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

mxArray *sf_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

static const mxArray
  *sf_get_sim_state_info_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S'type','srcId','name','auxInfo'{{M[8],M[0],T\"is_active_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 1, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "76ewK8nMw8g4GGMV2knw9C";
}

static void sf_opaque_initialize_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  initialize_params_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
  initialize_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  enable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  disable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  sf_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct* S)
{
  ChartInfoStruct *chartInfo = (ChartInfoStruct*) ssGetUserData(S);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol();/* state var info */
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

extern void sf_internal_set_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
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
    sf_get_sim_state_info_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct* S)
{
  return sf_internal_get_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S);
}

static void sf_opaque_set_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S, st);
}

static void sf_opaque_terminate_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
                    chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_optimization_info();
    }

    finalize_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
      ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
       chartInstanceVar);
    utFree((void *)chartInstanceVar);
    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
    ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
  (SimStruct *S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    initialize_params_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol
      ((SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct*)
       (((ChartInfoStruct *)ssGetUserData(S))->chartInstance));
  }
}

static void mdlSetWorkWidths_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(S,sf_get_instance_specialization(),infoStruct,
      4);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(S,sf_get_instance_specialization(),
                infoStruct,4,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop(S,
      sf_get_instance_specialization(),infoStruct,4,
      "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(S,sf_get_instance_specialization(),infoStruct,4);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 2, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 3, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 4, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 5, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 6, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,4,7);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=0; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 7; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,4);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(2655056267U));
  ssSetChecksum1(S,(2299337288U));
  ssSetChecksum2(S,(372065552U));
  ssSetChecksum3(S,(1385441503U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(SimStruct *S)
{
  SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *chartInstance;
  chartInstance = (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct *)
    utMalloc(sizeof(SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc4_Get_RE_RhythmCalc_Sig2Mbed_TcontrolInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW =
    mdlRTW_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol;
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

void c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_method_dispatcher(SimStruct *S,
  int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c4_Get_RE_RhythmCalc_Sig2Mbed_Tcontrol_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
