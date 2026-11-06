import { colors } from '../../theme/colors';
import { Tabs } from 'expo-router';
import { Icon } from '../../components/Icon';

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: colors.accent,
        tabBarInactiveTintColor: colors.muted,
        tabBarStyle: { backgroundColor: colors.background, borderTopColor: colors.border },
        sceneStyle: { backgroundColor: colors.background },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: 'Início',
          tabBarIcon: ({ color }) => <Icon name="house" color={color} size={20} />,
        }}
      />
      <Tabs.Screen
        name="biblia"
        options={{
          title: 'Bíblia',
          tabBarIcon: ({ color }) => <Icon name="book-bible" color={color} size={20} />,
        }}
      />
      <Tabs.Screen
        name="rastreamento"
        options={{
          title: 'Rastreamento',
          tabBarIcon: ({ color }) => <Icon name="chart-pie" color={color} size={20} />,
        }}
      />
      <Tabs.Screen
        name="planos"
        options={{
          title: 'Planos',
          tabBarIcon: ({ color }) => <Icon name="calendar-days" color={color} size={20} />,
        }}
      />
      <Tabs.Screen
        name="voce"
        options={{
          title: 'Você',
          tabBarIcon: ({ color }) => <Icon name="user" color={color} size={20} />,
        }}
      />
    </Tabs>
  );
}

