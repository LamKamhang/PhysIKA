/*
 * @file vector_1d.cpp 
 * @brief 1d vector.
 * @author Fei Zhu, Wei Chen
 * 
 * This file is part of Physika, a versatile physics simulation library.
 * Copyright (C) 2013- Physika Group.
 *
 * This Source Code Form is subject to the terms of the GNU General Public License v2.0. 
 * If a copy of the GPL was not distributed with this file, you can obtain one at:
 * http://www.gnu.org/licenses/gpl-2.0.html
 *
 */

#include <limits>
#include "Physika_Core/Utilities/math_utilities.h"
#include "Physika_Core/Utilities/physika_exception.h"
//#include "Physika_Core/Matrices/matrix_1x1.h"
#include "Physika_Core/Vectors/vector_1d.h"

namespace Physika{

template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar,1>::Vector()
    :Vector(0) //delegating ctor
{
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar,1>::Vector(Scalar x)
    :data_(x)
{
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Scalar& Vector<Scalar,1>::operator[] (unsigned int idx)
{
    return const_cast<Scalar &> (static_cast<const Vector<Scalar, 1> &>(*this)[idx]);
}

template <typename Scalar>
CPU_GPU_FUNC_DECL const Scalar& Vector<Scalar,1>::operator[] (unsigned int idx) const
{
#ifndef __CUDA_ARCH__
    if(idx>=1)
        throw PhysikaException("Vector index out of range!");
#endif
    return data_;
}



template <typename Scalar>
CPU_GPU_FUNC_DECL const Vector<Scalar,1> Vector<Scalar,1>::operator+ (const Vector<Scalar,1> &vec2) const
{
    return Vector<Scalar,1>(*this) += vec2;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar,1>& Vector<Scalar,1>::operator+= (const Vector<Scalar,1> &vec2)
{
    (*this)[0] += vec2[0];
    return *this;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL const Vector<Scalar,1> Vector<Scalar,1>::operator- (const Vector<Scalar,1> &vec2) const
{
    return Vector<Scalar, 1>(*this) -= vec2;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar,1>& Vector<Scalar,1>::operator-= (const Vector<Scalar,1> &vec2)
{
    (*this)[0] -= vec2[0];
    return *this;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL bool Vector<Scalar,1>::operator== (const Vector<Scalar,1> &vec2) const
{
    if(is_floating_point<Scalar>::value)
    {
        if(isEqual((*this)[0],vec2[0])==false)
            return false;
    }
    else
    {
        if((*this)[0] != vec2[0])
            return false;
    }
    return true;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL bool Vector<Scalar,1>::operator!= (const Vector<Scalar,1> &vec2) const
{
    return !((*this)==vec2);
}

template <typename Scalar>
CPU_GPU_FUNC_DECL const Vector<Scalar, 1> Vector<Scalar, 1>::operator+(Scalar value) const
{
    return Vector<Scalar, 1>(*this) += value;
}


template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar, 1>& Vector<Scalar, 1>::operator+= (Scalar value)
{
    (*this)[0] += value;
    return *this;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL const Vector<Scalar, 1> Vector<Scalar, 1>::operator-(Scalar value) const
{
    return Vector<Scalar, 1>(*this) -= value;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar, 1>& Vector<Scalar, 1>::operator-= (Scalar value)
{
    (*this)[0] -= value;
    return *this;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL const Vector<Scalar,1> Vector<Scalar,1>::operator* (Scalar scale) const
{
    return Vector<Scalar,1>(*this) *= scale;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar, 1>& Vector<Scalar, 1>::operator*= (Scalar scale)
{
    (*this)[0] *= scale;
    return *this;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL const Vector<Scalar,1> Vector<Scalar,1>::operator/ (Scalar scale) const
{
    return Vector<Scalar,1>(*this) /= scale;
}

    
template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar,1>& Vector<Scalar,1>::operator/= (Scalar scale)
{
#ifndef __CUDA_ARCH__
    if(abs(scale) <= std::numeric_limits<Scalar>::epsilon())
        throw PhysikaException("Vector Divide by zero error!");
#endif

    (*this)[0] /= scale;
    return *this;
}
    

template <typename Scalar>
CPU_GPU_FUNC_DECL const Vector<Scalar, 1> Vector<Scalar, 1>::operator-(void) const
{
    return Vector<Scalar, 1>(-(*this)[0]);
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Scalar Vector<Scalar,1>::norm() const
{
    return abs((*this)[0]);
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Scalar Vector<Scalar,1>::normSquared() const
{
    Scalar result = (*this)[0]*(*this)[0];
    return result;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Vector<Scalar,1>& Vector<Scalar,1>::normalize()
{
    Scalar norm = (*this).norm();
    bool nonzero_norm = norm > std::numeric_limits<Scalar>::epsilon();
    if(nonzero_norm)
        (*this)[0] /= norm;
    return *this;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Scalar Vector<Scalar,1>::cross(const Vector<Scalar,1>& vec2) const
{
    //cross product of 2 1d vectors is 0
    return 0;
}

template <typename Scalar>
CPU_GPU_FUNC_DECL Scalar Vector<Scalar,1>::dot(const Vector<Scalar,1>& vec2) const
{
    return (*this)[0]*vec2[0];
}

/*
template <typename Scalar>
CPU_GPU_FUNC_DECL const SquareMatrix<Scalar,1> Vector<Scalar,1>::outerProduct(const Vector<Scalar,1> &vec2) const
{
    SquareMatrix<Scalar,1> result;
    for(unsigned int i = 0; i < 1; ++i)
        for(unsigned int j = 0; j < 1; ++j)
            result(i,j) = (*this)[i]*vec2[j];
    return result;
}
*/

//explicit instantiation of template so that it could be compiled into a lib
template class Vector<unsigned char,1>;
template class Vector<unsigned short,1>;
template class Vector<unsigned int,1>;
template class Vector<unsigned long,1>;
template class Vector<unsigned long long,1>;
template class Vector<signed char,1>;
template class Vector<short,1>;
template class Vector<int,1>;
template class Vector<long,1>;
template class Vector<long long,1>;
template class Vector<float,1>;
template class Vector<double,1>;
template class Vector<long double,1>;

} //end of namespace Physika