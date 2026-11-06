import FontAwesome6 from '@expo/vector-icons/FontAwesome6';
import type { ComponentProps } from 'react';

/** Mesma família Font Awesome 6 do protótipo, sem caracteres Unicode substitutos. */
export function Icon({ name, size = 16, color = '#99c3a6' }: { name: ComponentProps<typeof FontAwesome6>['name']; size?: number; color?: ComponentProps<typeof FontAwesome6>['color'] }) {
  return <FontAwesome6 name={name} size={size} color={color} solid accessible={false} />;
}
