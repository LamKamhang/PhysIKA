/*
* @file shader_program.h
* @Brief Class ShaderProgram used to generate openGL program from shaders
* @author Wei Chen
*
* This file is part of Physika, a versatile physics simulation library.
* Copyright (C) 2013- Physika Group.
*
* This Source Code Form is subject to the terms of the GNU General Public License v2.0.
* If a copy of the GPL was not distributed with this file, you can obtain one at:
* http://www.gnu.org/licenses/gpl-2.0.html
*
*/

#ifndef PHYSIKA_RENDER_OPENGL_SHADERS_SHADER_PROGRAM_H
#define PHYSIKA_RENDER_OPENGL_SHADERS_SHADER_PROGRAM_H

#include <string>
#include "Physika_Render/OpenGL_Primitives/opengl_primitives.h"

#include <glm/fwd.hpp>

#include "Physika_Core/Vectors/vector_2d.h"
#include "Physika_Core/Vectors/vector_3d.h"
#include "Physika_Core/Vectors/vector_4d.h"

#include "Physika_Core/Matrices/matrix_2x2.h"
#include "Physika_Core/Matrices/matrix_3x3.h"
#include "Physika_Core/Matrices/matrix_4x4.h"

namespace Physika {

class ShaderProgram
{
public:

    ShaderProgram() = default;

    //disable copy
    ShaderProgram(const ShaderProgram & rhs) = delete;
    ShaderProgram & operator = (const ShaderProgram & rhs) = delete;

    ~ShaderProgram();

    /*
    ShaderProgram(const char * vertex_shader_source,
                  const char * fragment_shader_source,
                  const char * geometry_shader_source = nullptr,
                  const char * tess_control_shader_source = nullptr,
                  const char * tess_evaluation_shader_source = nullptr);
    */

    void createFromCStyleString(const char * vertex_shader_source,
                                const char * fragment_shader_source,
                                const char * geometry_shader_source = nullptr,
                                const char * tess_control_shader_source = nullptr,
                                const char * tess_evaluation_shader_source = nullptr);

    void  createFromFile(const std::string & vertex_shader_file,
                         const std::string & fragment_shader_file,
                         const std::string & geometry_shader_file = {},
                         const std::string & tess_control_shader_file = {},
                         const std::string & tess_evaluation_shader_file = {});

    void createFromString(const std::string & vertex_shader_str,
                          const std::string & fragment_shader_str,
                          const std::string & geometry_shader_str = {},
                          const std::string & tess_control_shader_str = {},
                          const std::string & tess_evaluation_shader_str = {});

    void destory();

    void use() const;
    void unUse() const;

    //setter
    bool setBool(const std::string & name, bool val);
    bool setInt(const std::string & name, int val);
    bool setFloat(const std::string & name, float val);

    bool setVec2(const std::string & name, const Vector2f & val);
    bool setVec2(const std::string & name, const glm::vec2 & val);
    bool setVec2(const std::string & name, float x, float y);

    bool setVec3(const std::string & name, const Vector3f & val);
    bool setVec3(const std::string & name, const glm::vec3 & val);
    bool setVec3(const std::string & name, float x, float y, float z);
    
    bool setVec4(const std::string & name, const Vector4f & val);
    bool setVec4(const std::string & name, const glm::vec4 & val);
    bool setVec4(const std::string & name, float x, float y, float z, float w);

    bool setMat2(const std::string & name, const Matrix2f & val);
    bool setMat2(const std::string & name, const glm::mat2 & val);

    bool setMat3(const std::string & name, const Matrix3f & val);
    bool setMat3(const std::string & name, const glm::mat3 & val);
    
    bool setMat4(const std::string & name, const Matrix4f & val);
    bool setMat4(const std::string & name, const glm::mat4 & val);

    bool isValid() const;
    GLuint id() const;

private:
    void check() const;


private:
    GLuint program_ = 0;
};

} // end of namespace Physika

#endif //PHYSIKA_RENDER_OPENGL_SHADERS_SHADER_PROGRAM_H
