import { useContext } from 'react'
import { AppContext } from './contexts/AppContext'
import { Navigate, Outlet, useRoutes } from 'react-router-dom'
import Login from './pages/Login'
import CusLogin from './pages/CusLogin'
import Home from './pages/Home'

function RejectedRoute() {
  const { isAuthen } = useContext(AppContext)
  return !isAuthen ? <Outlet /> : <Navigate to='/' />
}

export default function useRouteElements() {
  const elements = useRoutes([
    {
      path: '/',
      element: <Home />
    },
    {
      path: '/',
      element: <RejectedRoute />,
      children: [
        {
          path: '/login',
          element: <Login />
        },
        {
          path: '/cusLogin',
          element: <CusLogin />
        }
      ]
    }
  ])
  return elements
}
