# �p�b�P�[�W�̓ǂݍ���
library(rstan)
library(brms)

# �v�Z�̍�����
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
# �J�e�S���~���ʁF���f���� ---------------------------------------------------------

# ���͑Ώۂ̃f�[�^
interaction_2 <- read.csv("3-10-2-interaction-2.csv")
head(interaction_2, n = 3)

# �f�[�^�̗v��
summary(interaction_2)

# �Q�l�F�f�U�C���s��̍쐬
model.matrix(sales ~ publicity * temperature, interaction_2)

# ���f����
interaction_brms_2 <- brm(
  formula = sales ~ publicity * temperature,
  family = gaussian(link = "identity"),
  data = interaction_2,
  seed = 1,
  prior = c(set_prior("", class = "Intercept"),
            set_prior("", class = "sigma"))
)


# MCMC�̌��ʂ̊m�F
interaction_brms_2

# �Q�l�F���㕪�z�̐}��
plot(interaction_brms_2)
# �J�e�S���~���ʁF�W���̉��� ---------------------------------------------------------

# ���ݍ�p�̌��ʂ̊m�F
# �����ϐ������
newdata_2 <- data.frame(
  publicity   = rep(c("not", "to_implement"), each = 2),
  temperature = c(0,10,0,10)
)
newdata_2
# �\��
round(fitted(interaction_brms_2, newdata_2), 2)
# �J�e�S���~���ʁF���f���̐}�� ---------------------------------------------------------

# ��A�����̐}��
eff_2 <- marginal_effects(interaction_brms_2,
                          effects = "temperature:publicity")
plot(eff_2, points = T)