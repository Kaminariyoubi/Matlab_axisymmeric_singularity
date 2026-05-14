# Matlab_axisymmeric_singularity

This MATLAB project has two main files for running:

- main.m (Solve the equations, verify the accuracy of the solution and make the plots)
- Pathline.m (Plot the pathlines)

- Moreover, the file config.m stores the parameters.

## 1. Governing functions

Our aim is to solve $\gamma$, $\omega$ under the Eulerian coordinates and the pathline $(r, \theta, z)$ under the Lagrangian coordinates. In this project, we only consider the case when $\gamma_0 = f\left(1 - \frac{2}{R^2}r_0^2\right)$. Note that $S_* = \frac{1}{|f|}$.

As the paper states, the equation of the auxillary function $S(t)$ is governed by the following ODE:

$$
    \dot{S}(t) = \left\langle \frac{1}{1 + \gamma_0(\cdot) S(t)} \right\rangle_0^{-2}, \quad S(0) = 0.
$$

To improve the accuracy of the simulation, we apply the transformation: $S(t) = S_* \left[1 - e^{y(t)}\right]$, thus, $y(t) = \ln{\left(1 - \frac{S}{S_*}\right)}$, into the ODE, and we obtain that

$$
    \frac{dy}{dt} = -\frac{e^{-y}}{S_* }\left\langle \frac{1}{1 + \gamma_0 S_* \left[1 - e^{y(t)}\right]} \right\rangle_0^{-2}.
$$

We apply the fourth-order Runge-Kuta methods to this equation with Simpson's rule for integration and obtain the solution of $y(t)$. Then by the transformation, we could obtain the solution of $S(t)$ as well.

Then, according to the paper, we could directly obtain the time derivatives of $S(t)$ and the singularity time $T_*$:

$$
\begin{aligned}
    \dot{S}(t) &= 4 {f}^2 S(t)^2 \left[ \ln \left| \frac{1 - {f} S(t)}{1 + {f} S(t)} \right| \right]^{-2},\\
    \ddot{S}(t) &=  {32f^4S(t)^3\left[ \ln \left| \frac{1 - {f} S(t)}{1 + {f} S(t)} \right| \right]^{-5}\left[\ln \left| \frac{1 - {f} S(t)}{1 + {f} S(t)} \right| + \frac{2f S(t)}{1-f^2S(t)^2}\right]},\\
    T_* &= \frac{1}{4f^2}\int_0^{S_*} \frac{1}{S^2}\left( \ln{\frac{1 - fS}{1 + fS}} \right)^2 dS,
\end{aligned}
$$

then we could obtain the solutions of the pathline:

$$
\begin{aligned}
    r(r_0, t) &= \frac{\dot{S}^{1/4} R}{\sqrt{2 S}} \left[ -\frac{1}{{f}} \ln \left| 1 - \frac{2 {f} S r_0^2}{(1 + {f} S) R^2} \right| \right]^{1/2},\\
    \theta(\theta_0, r_0, t) &= \theta_0 - \frac{2 {f}}{R^2} \int_0^{r_0} \omega_0(r_0') r_0' \, \mathrm{d}r_0' \cdot \int_0^t \frac{S}{\sqrt{\dot{S}} \ln \left| 1 - \frac{2 {f} S}{R^2 (1 + {f} S)} r_0^2 \right|} \mathrm{d}t', \\
    z(r_0, z_0, t) &= -\frac{2 {f} S z_0}{\sqrt{\dot{S}} R^2} r_0^2 + \frac{z_0 (1 + {f} S)}{\sqrt{\dot{S}}}
\end{aligned}
$$

and the solutions of $\gamma$ and $\omega$:

$$
\begin{aligned}
    \gamma(r, t) &= -\frac{\dot{S}}{S (1 + {f} S)} \exp\left( \frac{2 {f} S r^2}{\sqrt{\dot{S}} R^2} \right) + \frac{\dot{S}}{S} - \frac{\ddot{S}}{2 \dot{S}}, \\
    \omega(r, t) &= \omega_0(r_0(r,t)) \frac{1 + {f} S}{\sqrt{\dot{S}}} \exp\left( -\frac{2 {f} S r^2}{\sqrt{\dot{S}} R^2} \right).
\end{aligned}
$$

## 2. Numerical simulation


