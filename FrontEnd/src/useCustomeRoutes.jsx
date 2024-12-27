import { useContext } from 'react'
import { AppContext } from './contexts/AppContext'
import { Navigate, Outlet, useRoutes } from 'react-router-dom'
import Login from './pages/Login'
import Home from './pages/Home'

function RejectedRoute() {
  const { isAuthenticated } = useContext(AppContext)
  return !isAuthenticated ? <Outlet /> : <Navigate to='/' />
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
      children: [{
        path: '/login',
        element: <Login />
      }]
    }
  ])
  return elements
}
